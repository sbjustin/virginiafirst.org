class Event < ActiveRecord::Base
  belongs_to :game
  has_many :positions, class_name: Volunteer::Position
  belongs_to :program, class_name: "FirstProgram"
  has_many :volunteer_registrations, class_name: Volunteer::Registration
  has_many :volunteer_profiles, through: :volunteer_registrations

  scope :sorted, ->(order='ASC') { order("starts_at #{order}") }
  scope :upcoming, -> { where("starts_at > ?", Date.today).order("starts_at ASC") }

  attr_accessible :name, :participant_limit, :program_id
  attr_accessible :setup_at, :starts_at, :teardown_at
  attr_accessible :city, :state, :street, :venue, :zip
  attr_accessible :positions_attributes

  accepts_nested_attributes_for :positions, allow_destroy: true

  validates_presence_of :name
  validates_presence_of :program
  validate :address_is_provided

  geocoded_by :full_address
  after_validation :geocode

  def count_unfilled_positions
    Volunteer::Position.
        joins("LEFT OUTER JOIN volunteer_assignments ON volunteer_assignments.position_id = volunteer_positions.id").
        group("volunteer_positions.id, volunteer_positions.event_id, volunteer_positions.needed_count").
        select("volunteer_positions.id, needed_count as needed, count(volunteer_assignments.id) as assigned").
        where({event_id: id}).having("count(volunteer_assignments.id) < needed_count")
  end

  def fullfillment
    total_filled_positions.to_f / total_positions_required.to_f
  end

  def full_address
    fields = [street, city, state, zip]
    fields.delete_if { |f| f.blank? }
    fields.join(", ")
  end

  def total_filled_positions
    total_positions_required - total_unfilled_positions
  end

  def total_positions_required
    positions.sum(&:needed_count)
  end

  def total_unfilled_positions
    counts = count_unfilled_positions
    unfilled_assignments = 0
    counts.each do |count|
      needed = count.needed.to_i
      assigned = count.assigned.to_i
      unfilled_assignments += needed - assigned
    end
    unfilled_assignments
  end

  def to_s
    name
  end

  def unassigned_volunteers
    volunteer_registrations.
        includes([:profile, :assignments]).
        where(volunteer_assignments: { registration_id: nil }).
        order("LOWER(profiles.last_name) ASC, LOWER(profiles.first_name) ASC")
  end

  def unfullfillment
    1.0 - fullfillment
  end

  def unused_roles
    if positions.count > 0
      Volunteer::Role.where("id NOT IN (?)", positions.map(&:role_id))
    else
      Volunteer::Role.all
    end
  end

  private

  def address_is_provided
    required_fields = [:street, :city, :state, :zip]
    errors.add_on_blank(required_fields)

    missing_fields = errors.keys & required_fields
    if missing_fields.present?
      humanize = missing_fields.map { |f| f.to_s.humanize }
      errors.add(:address, "is missing #{humanize.join(", ")}")
      false
    end
    true
  end
end

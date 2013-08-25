class FirstProgram < ActiveRecord::Base
  attr_accessible :abbr, :code, :flag, :icon, :name

  mount_uploader :icon, IconUploader
  mount_uploader :flag, FlagUploader

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code

  def to_s
    name
  end
end
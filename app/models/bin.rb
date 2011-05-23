class Bin < ActiveRecord::Base
  has_many :books
  validates_presence_of :name

  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
end

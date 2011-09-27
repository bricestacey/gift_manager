class Bin < ActiveRecord::Base
  has_many :books
  validates :name, presence: true

  scope :active, where(:active => true)
  scope :inactive, where(:active => false)

  SCOPES = [:active, :inactive]
end

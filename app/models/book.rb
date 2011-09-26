class Book < ActiveRecord::Base
  belongs_to :donor
  belongs_to :bin

  validates_presence_of :title, :author, :donor_id

  scope :undecided, where(:recommendation => 'undecided')
  scope :keep,      where(:recommendation => 'keep')
  scope :toss,      where(:recommendation => 'toss')

  scope :today,     where('date(created_at) = ?', Date.today)

  SCOPES = [:undecided, :keep, :toss, :today]
end

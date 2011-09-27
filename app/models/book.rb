class Book < ActiveRecord::Base
  belongs_to :donor
  belongs_to :bin

  validates :title, :author, :donor, :donor_id, :bin, :bin_id, presence: true
  validates :recommendation, presence: true, inclusion: { in: ['undecided', 'keep', 'trash', 'sell'] }

  scope :undecided, where(:recommendation => 'undecided')
  scope :keep,      where(:recommendation => 'keep')
  scope :toss,      where(:recommendation => 'toss')

  scope :today,     where('date(created_at) = ?', Date.today)

  SCOPES = [:undecided, :keep, :toss, :today]
end

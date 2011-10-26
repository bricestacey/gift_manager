class Book < ActiveRecord::Base
  belongs_to :donor
  belongs_to :bin

  validates :title, :author, :donor, :donor_id, :bin, :bin_id, presence: true
  validates :recommendation, presence: true, inclusion: { in: ['undecided', 'keep', 'trash', 'sell'] }

  scope :undecided, where(:recommendation => 'undecided')
  scope :keep,      where(:recommendation => 'keep')
  scope :trash,     where(:recommendation => 'trash')
  scope :sell,      where(:recommendation => 'sell')

  scope :today,     where('date(created_at) = ?', Date.today)
end

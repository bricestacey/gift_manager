class Book < ActiveRecord::Base
  belongs_to :donor
  belongs_to :bin

  validates_presence_of :title, :author, :donor_id, :bin_id

  scope :undecided, where(:recommendation => 'undecided')
  scope :keep,      where(:recommendation => 'keep')
  scope :toss,      where(:recommendation => 'toss')
end

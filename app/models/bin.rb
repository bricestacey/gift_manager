class Bin < ActiveRecord::Base
  has_many :books
  validates :name, presence: true

  scope :active, where(:active => true)
  scope :inactive, where(:active => false)

  before_save :ensure_books_decided, unless: :active?

  private
  def ensure_books_decided
    return false if books.undecided.count > 0
  end
end

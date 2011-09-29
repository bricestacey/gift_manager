class PagesController < ApplicationController
  def home
    @counts = {
      today: Book.today.count,
      today_undecided: Book.today.undecided.count,
      today_keep: Book.today.keep.count,
      today_trash: Book.today.trash.count,
      total: Book.count,
      total_undecided: Book.undecided.count,
      total_keep: Book.keep.count,
      total_trash: Book.trash.count
    }
  end

end

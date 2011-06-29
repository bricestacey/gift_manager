module Voyager 
  class BookObserver < ActiveRecord::Observer
    observe :book

    def after_initialize(model)
      # code to lookup item information
    end
  end
end

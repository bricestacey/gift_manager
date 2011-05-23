module ApplicationHelper
  def title
    if @title
      "#{@title} | Gift Manager"
    else
      "Gift Manager"
    end
  end
end

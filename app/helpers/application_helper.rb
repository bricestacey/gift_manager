module ApplicationHelper
  def title
    if @title
      "#{@title} | Gift Manager"
    else
      "Gift Manager"
    end
  end

  def breadcrumbs(crumbs)
    raw(crumbs.map {|text, path| link_to text, path}.join(content_tag(:span, "/", :class => 'breadcrumb-seperator')) + content_tag(:span, "/", :class => 'breadcrumb-seperator'))
  end
end

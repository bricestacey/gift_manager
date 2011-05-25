module ApplicationHelper
  def title
    if @title
      "#{@title} | Gift Manager"
    else
      "Gift Manager"
    end
  end

  # Assumes crumbs is an ordered hash
  def breadcrumbs(crumbs)
    raw(crumbs.map {|text, path| link_to text, path}.join(content_tag(:span, "/", :class => 'breadcrumb-seperator')) + content_tag(:span, "/", :class => 'breadcrumb-seperator'))
  end
end

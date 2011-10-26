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
    crumbs = crumbs.map { |text, path| link_to text, path }
    crumbs = crumbs.join(content_tag(:span, "/", class: 'breadcrumb-seperator'))
    crumbs = crumbs + content_tag(:span, "/", class: 'breadcrumb-seperator')
    crumbs.html_safe
  end
end

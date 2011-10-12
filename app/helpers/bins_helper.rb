module BinsHelper

  def link_to_bin_facet(val)
    case val
    when :active
      text = "Active (#{Bin.active.count})"
      if params[:active].nil? || params[:active] == 'true'
        content_tag(:span, text)
      else
        link_to text, bins_path(active: true)
      end
    when :inactive
      text = "Inactive (#{Bin.inactive.count})"
      if params[:active] == 'false'
        content_tag(:span, text)
      else
        link_to(text, bins_path(active: false))
      end
    end
  end

end

module BinsHelper

  def link_to_bin_facet(val)
    case val
    when :active
      text = "Active (#{Bin.active.count})"
      if params[:active].nil? || params[:active] == 'true'
        link_to text, bins_path(active: true), class: 'btn primary'
      else
        link_to text, bins_path(active: true), class: 'btn'
      end
    when :inactive
      text = "Inactive (#{Bin.inactive.count})"
      if params[:active] == 'false'
        link_to text, bins_path(active:false), class: 'btn primary'
      else
        link_to text, bins_path(active: false), class: 'btn'
      end
    end
  end

end

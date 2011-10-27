require 'spec_helper'

describe BinsHelper do
  describe "#link_to_bin_facet" do
    context "given we're viewing Active Bins" do
      before(:each) { params[:active] = 'true' }

      it "should not link :active" do
        link_to_bin_facet(:active).should include("Active (#{Bin.active.count})")
      end

      it "should link :inactive" do
        link_to_bin_facet(:inactive).should include("Inactive (#{Bin.inactive.count})")
        link_to_bin_facet(:inactive).should include(bins_path(active: false))
      end
    end

    context "given we're viewing Inactive Bins" do
      before(:each) { params[:active] = 'false' }

      it "should not link :inactive" do
        link_to_bin_facet(:inactive).should include("Inactive (#{Bin.inactive.count})")
      end

      it "should link :active" do
        link_to_bin_facet(:active).should include("Active (#{Bin.active.count})")
        link_to_bin_facet(:active).should include(bins_path(active: true))
      end
    end
  end
end

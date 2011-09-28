Then /^I should see the following bins:$/ do |bins|
  bins.hashes.each do |attributes|
    @bin = Bin.find_by_name(attributes[:name])
    attributes.each_pair do |key, value|
      Then %{I should see "#{value}" within ".bin-#{@bin.id} .bin-#{key}"}
    end
  end
end

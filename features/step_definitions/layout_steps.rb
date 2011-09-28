Then /^I should see an? "([^"]*)" action item$/ do |text|
  Then %{I should see "#{text}" within the action items}
end

Then /^I should see the following breadcrumbs$/ do |crumbs|
  crumbs.hashes.each do |crumb|
    Then %{I should see "#{crumb[:text]}" within ".breadcrumb"}
  end
end

Then /^I should see an? "([^"]*)" facet is selected$/ do |facet|
  Then %{I should see "#{facet}" within ".primary" within ".scope"}
end

Then /^I should see an? "([^"]*)" facet$/ do |facet|
  Then %{I should see "#{facet}" within ".scope"}
end

Then /^I should see the following action items:$/ do |table|
  table.raw.flatten.each do |item|
    Then %{I should see "#{item}" within the action items}
  end
end

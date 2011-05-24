Then /^I should see an? "([^"]*)" action item$/ do |text|
  Then "I should see \"#{text}\" within \".action_items\""
end

Then /^I should see the following breadcrumbs$/ do |crumbs|
  crumbs.hashes.each do |crumb|
    Then "I should see \"#{crumb[:text]}\" within \".breadcrumb\""
  end
end

Then /^I should see the title \"([^\"]*)\"$/ do |text|
  Then "I should see \"#{text}\" within \"title\""
  Then "I should see \"#{text}\" within \".page_title\""
end

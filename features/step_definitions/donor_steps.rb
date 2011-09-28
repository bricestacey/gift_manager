Then /^I should see (\d+) books? (are|is|were|was) (.*)$/ do |count, ignore, recommendation|
  Then %{I should see "#{count}" within ".books-#{recommendation}"}
end

Then /^I should see pagination$/ do
  Then %{I should see "1" within ".pagination"}
  And  %{I should see "2" within ".pagination"}
  And  %{I should see "Next" within ".pagination"}
  And  %{I should see "Last" within ".pagination"}
end

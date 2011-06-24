When /^I fill in "ISBN" with the ISBN of a book with at least one circulation$/ do
  When %{I fill in "ISBN" with "#{ISBN_BOOK_CIRCULATED}"}
end

When /^I fill in "ISBN" with the ISBN of a book without a circulation$/ do
  When %{I fill in "ISBN" with "#{ISBN_BOOK_NOT_CIRCULATED}"}
end

Then /^I should see that there is at least one copy$/ do
  Then %{I should see /Copies [^0]/}
end

Then /^I should see that there is at least one circulation$/ do
  Then %{I should not see "Charges 0"}
end

Then /^I should see that it has not circulated$/ do
  Then %{I should see "Charges 0"}
end


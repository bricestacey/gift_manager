When /^I fill in "ISBN" with the ISBN of a book with at least one circulation$/ do
  When %{I fill in "ISBN" with "#{ISBN_BOOK_CIRCULATED}"}
end

When /^I fill in "ISBN" with the ISBN of a book without a circulation$/ do
  When %{I fill in "ISBN" with "#{ISBN_BOOK_NOT_CIRCULATED}"}
end

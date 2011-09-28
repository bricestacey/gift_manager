module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"

    when "the title"
      ".page_title"

    when "the action items"
      ".action_items"

    when /^the book with (.*) "([^"]*)"$/
      if $1 == 'isbn' 
        @book = Book.find_by_isbn($2)
        raise %{Can't find book with isbn "#{$2}".\n} if @book.nil?
      elsif $1 == 'title'
        @book = Book.find_by_title($2)
        raise %{Can't find book with title "#{$2}".\n} if @book.nil?
      else
        raise "Invalid attribute #{$1}"
      end
      ".book-#{@book.id}"

    when /^the bin "([^"]*)"$/
      @bin = Bin.find_by_name($1)
      raise %{Can't find bin "#{$1}".\n} if @bin.nil?
      ".bin-#{@bin.id}"

    when /^the donor "([^"]*)"$/
      @donor = Donor.find_by_name($1)
      raise %{Can't find the donor "#{$1}".\n} if @donor.nil?
      ".donor-#{@donor.id}"

    when /^the user "([^"]*)"$/
      @user = User.find_by_email($1)
      raise %{Can't find the user "#{$1}".\n} if @user.nil?
      ".user-#{@user.id}"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps as was previously the default for the
    # web steps:
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)

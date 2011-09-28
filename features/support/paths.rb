module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^login$/
      '/users/signin'

    when /^the home\s?page$/
      '/'

    when /^the bins page$/
      '/bins'

    when /^the page for bin (.+)$/
      "/bins/#{$1}"

    when /^the donors page$/
      '/donors'

    when /^the page for donor (.+)$/
      "/donors/#{$1}"

    when /^the books page$/
      '/books'

    when /^the page for the book with (.*) "([^"]*)"$/
      if $1 == 'isbn' 
        @book = Book.find_by_isbn($2)
        raise %{Can't find book with isbn "#{$2}".\n} if @book.nil?
      elsif $1 == 'title'
        @book = Book.find_by_title($2)
        raise %{Can't find book with title "#{$2}".\n} if @book.nil?
      else
        raise "Invalid attribute #{$1}"
      end
      "/books/#{@book.id}"

    when /^the page for adding a new bin$/
      "/bins/new"

    when /^the page for the bin "([^"]*)"$/
      @bin = Bin.find_by_name($1)
      raise %{Can't find bin "#{$1}".\n} if @bin.nil?
      "/bins/#{@bin.id}"

    when /^the page for the donor "([^"]*)"$/
      @donor = Donor.find_by_name($1)
      raise %{Can't find the donor "#{$1}".\n} if @donor.nil?
      "/donors/#{@donor.id}"

    when /^the page for the user "([^"]*)"$/
      @user = User.find_by_email($1)
      raise %{can't find the user "#{$1}".\n} if @user.nil?
      "/users/#{@user.id}"

    when /^the users page$/
      '/users'

    when /^the page for user (.+)$/
      "/users/#{$1}"

    when /^the book details for ISBN (.+)$/
      book_path(Book.find_by_isbn($1))

    when /^the latest book's details$/
      book_path(Book.order('created_at DESC').first)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

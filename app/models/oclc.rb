class OCLC
  def self.find_by_isbn(isbn)
    client = WCAPI::Client.new :wskey => APP_CONFIG['oclc']['wskey']
    record = client.GetRecord(:id => isbn, :servicelevel => 'full').record

    result = {}
    if record
      result.merge!({
        :title => record.title.delete_if{|t| t.blank?}.compact.join(', '),
        :author => record.authors.delete_if{|a| a.blank?}.compact.join(', '),
        :publisher => record.publisher,
        :published => record.publication_year,
        :series => record.series,
        :call_number => record.call_number
      })
    end

    locations = client.GetLocations(:id => isbn, :oclcsymbol => APP_CONFIG['oclc']['symbol_remote']).locations
    result.merge!({
      :held_local => locations.map {|l| l.code}.include?(APP_CONFIG['oclc']['symbol_local']),
      :held_remote => locations.map {|l| l.code}.join(', ')
    })

    result
  end
end

class OCLC
  @@client = WCAPI::Client.new wskey: APP_CONFIG['oclc']['wskey']
  
  # Return a hash of both bibliographic and location attributes for a given `isbn`
  def self.attributes_for_isbn(isbn)
    {}.tap do |result|
      result.merge! location_attributes_for_isbn(isbn)
      result.merge! bib_attributes_for_isbn(isbn)
    end
  end

  # Return the location attributes for a given `isbn`
  def self.location_attributes_for_isbn(isbn)
    locations = @@client.GetLocations(id: isbn, oclcsymbol: APP_CONFIG['oclc']['symbol_remote']).locations

    {}.tap do |result|
      result[:held_local] = locations.map {|l| l.code}.include?(APP_CONFIG['oclc']['symbol_local'])
      result[:held_remote] = locations.map {|l| l.code}.join(', ')
    end
  end

  # Return the bibliographic attributes for a given `isbn`
  def self.bib_attributes_for_isbn(isbn)
    record = @@client.GetRecord(id: isbn, servicelevel: 'full').record

    {}.tap do |result|
      if record
        result[:title]       = record.title.delete_if{|t| t.blank?}.compact.join(', ')
        result[:author]      = record.authors.delete_if{|a| a.blank?}.compact.join(', ')
        result[:publisher]   = record.publisher
        result[:published]   = record.publication_year
        result[:series]      = record.series
        result[:call_number] = record.call_number
      end
    end
  end
end

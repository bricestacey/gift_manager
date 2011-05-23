class AMZN
  def self.find_by_isbn(isbn)
    result = {}
    begin
      ::Rails.logger.info 'Running Amazon processing'
      options = {
        SearchIndex: 'Books',
        IdType: 'ISBN',
        Condition: 'All',
        ResponseGroup: 'Medium'
      }

      Amazon::Ecs.item_lookup(isbn, options).items.each do |item|
        small = item.get('SmallImage/URL')
        medium = item.get('MediumImage/URL')
        large = item.get('LargeImage/URL')
        result.merge!({
          :price_amazon => item.get('ItemAttributes/ListPrice/FormattedPrice'),
          :thumbnail => medium || small || large || nil
        })
      end 
    rescue Exception
      ::Rails.logger.warn 'Failed to process amazon data'
    end  
        
    result
  end        
end

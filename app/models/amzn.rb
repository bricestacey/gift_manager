class AMZN
  OPTIONS = {
    SearchIndex: 'Books',
    IdType: 'ISBN',
    Condition: 'All',
    ResponseGroup: 'Medium'
  }

  def self.attributes_for_isbn(isbn)
    {}.tap do |result|
      begin
        Amazon::Ecs.item_lookup(isbn, OPTIONS).items.each do |item|
          small = item.get('SmallImage/URL')
          medium = item.get('MediumImage/URL')
          large = item.get('LargeImage/URL')

          result[:price_amazon] = item.get('ItemAttributes/ListPrice/FormattedPrice')
          result[:thumbnail] = medium || small || large || nil
        end 
      rescue Exception
        ::Rails.logger.warn 'Failed to process amazon data'
      end  
    end
  end        
end

Factory.define :book do |b|
  b.isbn            { '0201853922' }
  b.title           { 'The art of computer programming /' }
  b.author          { 'Knuth, Donald Ervin,' }
  b.published       { '2005' }
  b.publisher       { 'Addison-Wesley' }
  b.series          { '' }
  b.call_number     { 'QA76.6 .K64 2005' }
  b.held_local      { true }
  b.held_remote     { 'AUM, BMU, BOS, BXM, MBB, MYG, NED, NHM, SMU, TFW' }
  b.price_amazon    { '$19.99' }
  b.thumbnail       { 'http://ecx.images-amazon.com/images/I/51C7CVG94XL._SL160_.jpg' }
  #b.recommendation  { '' }
  #b.donor           { '' }
  b.bin_id          { '1' }
end

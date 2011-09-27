FactoryGirl.define do
  factory :bin do
    name 'Top Shelf'
  end

  factory :book do
    isbn            { '0201853922' }
    title           { 'The art of computer programming /' }
    author          { 'Knuth, Donald Ervin,' }
    published       { '2005' }
    publisher       { 'Addison-Wesley' }
    series          { '' }
    call_number     { 'QA76.6 .K64 2005' }
    held_local      { true }
    held_remote     { 'AUM, BMU, BOS, BXM, MBB, MYG, NED, NHM, SMU, TFW' }
    price_amazon    { '$19.99' }
    thumbnail       { 'http://ecx.images-amazon.com/images/I/51C7CVG94XL._SL160_.jpg' }
    recommendation  'undecided'
    bin
    donor
  end

  factory :donor do
    name 'Anonymous'
  end

  factory :user do
    sequence(:email)      {|n| "factory#{n}@example.com" }
    password              'secret'
    password_confirmation 'secret'
  end
end

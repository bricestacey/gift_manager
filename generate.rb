model = 'Bin'
attributes = {
  :name => 'string',
}

puts "rails generate model #{model} #{attributes.map{|key, value| "#{key}:#{value}"}.join(' ')}"

model = 'Donor'
attributes = {
  :name => 'string',
  :phone => 'string',
  :email => 'string',
  :line1 => 'string',
  :line2 => 'string',
  :city => 'string',
  :state => 'string',
  :zip => 'string'
}


model = 'Book'
attributes = {
  :isbn => 'string',

  :title => 'string',
  :author => 'string',
  :published => 'string',
  :publisher => 'string',
  :series => 'string',
  :call_number => 'string',
  :held_local => 'boolean',
  :held_remote => 'string',
  :price_amazon => 'string',
  :thumbnail => 'string',

  :recommendation => 'string',

  :donor => 'references',
  :bin => 'references'
}

puts "rails generate model #{model} #{attributes.map{|key, value| "#{key}:#{value}"}.join(' ')}"

model = 'Donor'
attributes = {
  :name => 'string',
  :phone => 'string',
  :email => 'string',
  :line1 => 'string',
  :line2 => 'string',
  :city => 'string',
  :state => 'string',
  :zip => 'string'
}

puts "rails generate model #{model} #{attributes.map{|key, value| "#{key}:#{value}"}.join(' ')}"


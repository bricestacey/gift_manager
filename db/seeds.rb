# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

donor = Donor.create(:name => 'Anonymous')
bin = Bin.create(:name => 'Programming Books')

bin.books.create({
  "author"=>"Fowler, Martin,, Beck, Kent.",
  "call_number"=>"QA76.76.R42 F69 1999",
  "donor"=> donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>1, "isbn"=>"9780201485677",
  "price_amazon"=>"$64.99",
  "published"=>"1999",
  "publisher"=>"Reading, MA : Addison-Wesley, 1999.",
  "recommendation"=>"keep",
  "series"=>"The Addison-Wesley object technology series",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51T4YZ3HieL._SL160_.jpg",
  "title"=>"Refactoring :, improving the design of existing code /"
})

bin.books.create({
  "author"=>"Knuth, Donald Ervin,",
  "call_number"=>"QA76.6 .K64",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"AUM",
  "id"=>2, "isbn"=>"0201038099",
  "price_amazon"=>nil, "published"=>"1973",
  "publisher"=>"Reading, Mass. : Addison-Wesley Pub. Co., c1973-c1981.",
  "recommendation"=>"keep",
  "series"=>"Addison-Wesley series in computer science and information processing",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/31BK19VMQVL._SL160_.jpg",
  "title"=>"The art of computer programming /"
}) 

bin.books.create({
  "author"=>"Bentley, Jon Louis.",
  "call_number"=>"QA76.6 .B454 2000",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"AUM",
  "id"=>3, "isbn"=>"9780201657883",
  "price_amazon"=>"$39.99",
  "published"=>"2000",
  "publisher"=>"Reading, Mass. : Addison-Wesley, 2000.",
  "recommendation"=>"keep",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/41ETT7KQRRL._SL160_.jpg",
  "title"=>"Programming pearls /"
})
bin.books.create({
  "author"=>"Nemeth, Evi., Snyder, Garth.",
  "call_number"=>"QA76.76.O63 N448 2007",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"AUM",
  "id"=>4, "isbn"=>"9780131480049",
  "price_amazon"=>"$54.99",
  "published"=>"2007",
  "publisher"=>"Upper Saddle River, NJ : Prentice Hall, c2007.",
  "recommendation"=>"keep",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51VdpnUFGGL._SL160_.jpg",
  "title"=>"Linux administration handbook /"
})
bin.books.create({
  "author"=>"Schwartz, Alan,, Garfinkel, Simson.",
  "call_number"=>"HE7551 .S393 1998 TK5105.73 .S39 1998",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>5, "isbn"=>"9781565923881",
  "price_amazon"=>"$19.95",
  "published"=>"1998",
  "publisher"=>"Sebastopol, Calif. : O'Reilly, c1998.",
  "recommendation"=>"undecided",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/41GM1OSzqlL._SL160_.jpg",
  "title"=>"Stopping spam /"
})
bin.books.create({
  "author"=>"Kernighan, Brian W., Ritchie, Dennis M.,",
  "call_number"=>"QA76.73.C15 K47",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"AUM",
  "id"=>6, "isbn"=>"0131101633",
  "price_amazon"=>"$45.00",
  "published"=>"1978",
  "publisher"=>"Englewood Cliffs, N.J. : Prentice-Hall, c1978.",
  "recommendation"=>"toss",
  "series"=>"Prentice-Hall software series",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/41NH37S7YRL._SL160_.jpg",
  "title"=>"The C programming language /"
})
bin.books.create({
  "author"=>"Williams, Hugh E., Lane, David",
  "call_number"=>"QA76.73.P224 W55 2002",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>7, "isbn"=>"9780596000417",
  "price_amazon"=>"$44.95",
  "published"=>"2002",
  "publisher"=>"Beijing ; Sebastopol, CA : O'Reilly, c2002.",
  "recommendation"=>"undecided",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51nGZZD-P3L._SL160_.jpg",
  "title"=>"Web database applications with PHP & MySQL /"
})
bin.books.create({
  "author"=>"Mangano, Sal.",
  "call_number"=>"QA76.73.X58 M36 2003",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>8, "isbn"=>"9780596003722",
  "price_amazon"=>"$39.95",
  "published"=>"2002",
  "publisher"=>"Beijing ; Sebastopol, CA ; Farnham : O'Reilly, [2002], c2003.",
  "recommendation"=>"undecided",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51u21ENfaFL._SL160_.jpg",
  "title"=>"XSLT cookbook /"
})
bin.books.create({
  "author"=>"Schwartz, Randal L., Christiansen, Tom.",
  "call_number"=>"QA76.73.P22 S37 1997",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"AUM",
  "id"=>9, "isbn"=>"9781565922846",
  "price_amazon"=>"$34.95",
  "published"=>"1997",
  "publisher"=>"Sebastopol, CA : O'Reilly & Associates, c1997.",
  "recommendation"=>"undecided",
  "series"=>"A Nutshell handbook",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/511b4kdqNBL._SL160_.jpg",
  "title"=>"Learning Perl /"
})
bin.books.create({
  "author"=>"DuBois, Paul,",
  "call_number"=>"QA76.73.S67 D587 2003",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>10, "isbn"=>"9780596001452",
  "price_amazon"=>"$49.95",
  "published"=>"2003",
  "publisher"=>"Sebastopol, CA : O'Reilly, c2003.",
  "recommendation"=>"undecided",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51RS4PDUi8L._SL160_.jpg",
  "title"=>"MySQL Cookbook /"
})
bin.books.create({
  "author"=>"Gilmore, W. J.",
  "call_number"=>"QA76.73.S67 G56 2004",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>11, "isbn"=>"9781893115514",
  "price_amazon"=>"$39.99",
  "published"=>"2004",
  "publisher"=>"Berkeley, CA : Apress ; New York, NY : Distributed to the Book trade in the United States by Springer-Verlag New York, c2004.",
  "recommendation"=>"undecided",
  "series"=>"",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/31aBYrxohcL._SL160_.jpg",
  "title"=>"Beginning PHP 5 and MySQL :, from novice to professional /"
})
bin.books.create({
  "author"=>"Liu, Cricket.",
  "call_number"=>"TK5105.875.I57 M36 1994",
  "donor" => donor,
  "held_local"=>false, "held_remote"=>"",
  "id"=>12, "isbn"=>"9781565920620",
  "price_amazon"=>"$29.95",
  "published"=>"1994",
  "publisher"=>"Sebastopol, CA : O'Reilly & Associates, 1994.",
  "recommendation"=>"toss",
  "series"=>"Nutshell handbook",
  "thumbnail"=>"http://ecx.images-amazon.com/images/I/51aZJfhlK5L._SL160_.jpg",
  "title"=>"Managing Internet information services /"
})

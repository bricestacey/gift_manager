class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.text :isbn
      t.text :title
      t.text :author
      t.text :published
      t.text :publisher
      t.text :series
      t.text :call_number
      t.boolean :held_local
      t.text :held_remote
      t.text :price_amazon
      t.text :thumbnail
      t.text :recommendation, :default => 'undecided'
      t.references :donor
      t.references :bin

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end

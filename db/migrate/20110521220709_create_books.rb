class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :published
      t.string :publisher
      t.string :series
      t.string :call_number
      t.boolean :held_local
      t.string :held_remote
      t.string :price_amazon
      t.string :thumbnail
      t.string :recommendation, :default => 'undecided'
      t.references :donor
      t.references :bin

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end

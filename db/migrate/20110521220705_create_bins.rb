class CreateBins < ActiveRecord::Migration
  def self.up
    create_table :bins do |t|
      t.text  :name
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :bins
  end
end

class AddLocalInfoToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :local_copies, :integer, :default => 0
    add_column :books, :local_charges, :integer, :default => 0
  end

  def self.down
    remove_column :books, :local_charges
    remove_column :books, :local_copies
  end
end

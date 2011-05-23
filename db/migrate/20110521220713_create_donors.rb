class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end

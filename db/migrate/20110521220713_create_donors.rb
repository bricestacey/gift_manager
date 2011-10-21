class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.text :name
      t.text :phone
      t.text :email
      t.text :line1
      t.text :line2
      t.text :city
      t.text :state
      t.text :zip

      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end

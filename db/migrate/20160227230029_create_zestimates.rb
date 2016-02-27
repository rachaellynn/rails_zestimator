class CreateZestimates < ActiveRecord::Migration
  def change
    create_table :zestimates do |t|
      t.string :name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :property_type
      t.integer :market_report
      t.integer :agent_contact
      t.string :contact
      t.text :commments
      t.timestamps null: false
    end
  end
end

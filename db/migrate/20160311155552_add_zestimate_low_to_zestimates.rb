class AddZestimateLowToZestimates < ActiveRecord::Migration
  def change
    add_column :zestimates, :zestimate_low, :string
  end
end

class AddZestimateHighToZestimates < ActiveRecord::Migration
  def change
    add_column :zestimates, :zestimate_high, :string
  end
end

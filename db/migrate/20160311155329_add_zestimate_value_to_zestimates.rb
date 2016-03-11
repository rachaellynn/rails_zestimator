class AddZestimateValueToZestimates < ActiveRecord::Migration
  def change
    add_column :zestimates, :zestimate_value, :string
  end
end

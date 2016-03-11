class AddZestimateValuestoZestimates < ActiveRecord::Migration
  # def change
  # 	add_column :zestimates, :zestimate_value, :string
  # 	add_column :zestimates, :zestimate_low, :string
  # 	add_column :zestimates, :zestimate_high, :string
  # end

#3/11/16 note that none of these migrations (above/below) worked. i'm not sure why. 
	change_table :zestimates do |t|
	  t.add_column :zestimate_value, :string
	  t.add_column :zestimate_low, :string
	  t.add_column :zestimate_high, :string
	end

end

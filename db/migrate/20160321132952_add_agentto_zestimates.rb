class AddAgenttoZestimates < ActiveRecord::Migration
  def change
  	add_column :zestimates, :assigned_agent, :string
  end
end

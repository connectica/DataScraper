class Add188DataToFirms < ActiveRecord::Migration
  def change
	add_column :firm, :1881Data, :string
  end
end

class AddEniroDataToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :enirodata, :string
  end
end

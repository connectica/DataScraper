class AddOrgnrToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :orgnr, :integer
  end
end

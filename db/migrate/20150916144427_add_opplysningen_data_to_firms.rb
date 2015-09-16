class AddOpplysningenDataToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :OpplysningenData, :string
  end
end

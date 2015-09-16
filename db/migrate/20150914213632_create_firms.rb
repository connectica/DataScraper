class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :enirodata
      t.integer :orgnr

      t.timestamps null: false
    end
  end
end

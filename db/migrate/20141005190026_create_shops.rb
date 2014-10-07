class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

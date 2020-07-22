class AddLocationToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :location, :string
  end
end

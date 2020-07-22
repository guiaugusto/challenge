class AddOrganizationToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :organization, :string
  end
end

class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :profile_name
      t.string :github_address
      t.string :github_username
      t.integer :amount_of_followers
      t.integer :amount_of_following
      t.integer :amount_stars
      t.integer :amount_contributions
      t.string :github_profile_image

      t.timestamps
    end
  end
end

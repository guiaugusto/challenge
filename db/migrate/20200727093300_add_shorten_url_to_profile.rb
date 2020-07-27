class AddShortenUrlToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :shorten_url, :string
  end
end

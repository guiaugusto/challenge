json.extract! profile, :id, :profile_name, :github_address, :github_username, :amount_of_followers, :amount_of_following, :amount_stars, :amount_contributions, :github_profile_image, :created_at, :updated_at
json.url profile_url(profile, format: :json)

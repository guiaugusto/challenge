require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    # Setup first user
    user_1 = Profile.new
    user_1.profile_name = "Guilherme Augusto"
    user_1.github_address = "https://github.com/guiaugusto"
    user_1.github_username = "guiaugusto"
    user_1.amount_of_followers = 28
    user_1.amount_of_following = 35
    user_1.amount_stars = 32
    user_1.amount_contributions = 622
    user_1.github_profile_image = "https://avatars2.githubusercontent.com/u/26304278?s=40&amp;v=4"
    user_1.organization = "@lappisunb"
    user_1.location = "Brazil"
    user_1.save!
    # Setup second user
    user_2 = Profile.new
    user_2.profile_name = "Matheus Richard"
    user_2.github_address = "https://github.com/matheusrich"
    user_2.github_username = "MatheusRich"
    user_2.amount_of_followers = 28
    user_2.amount_of_following = 21
    user_2.amount_stars = 229
    user_2.amount_contributions = 618
    user_2.github_profile_image = "https://avatars2.githubusercontent.com/u/26308178?s=40&amp;v=4"
    user_2.organization = "@Fretadão"
    user_2.location = "Brazil"
    user_2.save!
    # Setup third user
    user_3 = Profile.new
    user_3.profile_name = "Guilherme Lacerda"
    user_3.github_address = "https://www.github.com/guilacerda"
    user_3.github_username = "guilacerda"
    user_3.amount_of_followers = 49
    user_3.amount_of_following = 43
    user_3.amount_stars = 37
    user_3.amount_contributions = 388
    user_3.github_profile_image = "https://avatars2.githubusercontent.com/u/26508278?s=40&amp;v=4"
    user_3.organization = "@lappisunb"
    user_3.location = "Brazil"
    user_3.save!
  end

  test "should filter profile by username query" do
    query = "guilacerda"
    profiles = Profile.search(query)
    assert profiles.length == 1
  end

  test "should filter profiles by organization name query" do
    query = "@lappisunb"
    profiles = Profile.search(query)
    assert profiles.length == 2
  end
  
  test "should filter profiles by location query" do
    query = "Brazil"
    profiles = Profile.search(query)
    assert profiles.length == 3
  end

  test "should filter profiles by profile_name query" do
    query = "Gui"
    profiles = Profile.search(query)
    assert profiles.length == 2
  end

  test "should filter profiles without query content" do
    query = ""
    profiles = Profile.search(query)
    assert profiles.length == 3
  end

  test "should not find any profile with the specified query" do
    query = "Thalisson"
    profiles = Profile.search(query)
    assert profiles.length == 0
  end
end

require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = Profile.new
    @profile.profile_name = "Guilherme Augusto"
    @profile.github_address = "https://www.github.com/guiaugusto"
    @profile.github_username = "guiaugusto"
    @profile.amount_of_followers = 28
    @profile.amount_of_following = 35
    @profile.amount_stars = 32
    @profile.amount_contributions = 622
    @profile.github_profile_image = "https://bit.ly/2EcJXww"
    @profile.organization = "@lappisunb"
    @profile.location = "Brazil"
    @profile.save!
    
    @profile_name = "Guilherme Lacerda"
    @github_address = "https://www.github.com/guilacerda"

  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post profiles_url, params: {
        profile: {
          github_address: @github_address,
          profile_name: @profile_name
        }
      }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { amount_contributions: @profile.amount_contributions, amount_of_followers: @profile.amount_of_followers, amount_of_following: @profile.amount_of_following, amount_stars: @profile.amount_stars, github_address: @profile.github_address, github_profile_image: @profile.github_profile_image, github_username: @profile.github_username, profile_name: @profile.profile_name } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end

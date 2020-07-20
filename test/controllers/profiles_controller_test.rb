require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
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
      post profiles_url, params: { profile: { amount_contributions: @profile.amount_contributions, amount_of_followers: @profile.amount_of_followers, amount_of_following: @profile.amount_of_following, amount_stars: @profile.amount_stars, github_address: @profile.github_address, github_profile_image: @profile.github_profile_image, github_username: @profile.github_username, profile_name: @profile.profile_name } }
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

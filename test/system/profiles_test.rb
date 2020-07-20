require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:one)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "creating a Profile" do
    visit profiles_url
    click_on "New Profile"

    fill_in "Amount contributions", with: @profile.amount_contributions
    fill_in "Amount of followers", with: @profile.amount_of_followers
    fill_in "Amount of following", with: @profile.amount_of_following
    fill_in "Amount stars", with: @profile.amount_stars
    fill_in "Github address", with: @profile.github_address
    fill_in "Github profile image", with: @profile.github_profile_image
    fill_in "Github username", with: @profile.github_username
    fill_in "Profile name", with: @profile.profile_name
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "updating a Profile" do
    visit profiles_url
    click_on "Edit", match: :first

    fill_in "Amount contributions", with: @profile.amount_contributions
    fill_in "Amount of followers", with: @profile.amount_of_followers
    fill_in "Amount of following", with: @profile.amount_of_following
    fill_in "Amount stars", with: @profile.amount_stars
    fill_in "Github address", with: @profile.github_address
    fill_in "Github profile image", with: @profile.github_profile_image
    fill_in "Github username", with: @profile.github_username
    fill_in "Profile name", with: @profile.profile_name
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile" do
    visit profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile was successfully destroyed"
  end
end

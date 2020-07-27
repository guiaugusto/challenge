require 'nokogiri'
require 'test_helper'

class ProfileSpiderTest < ActiveSupport::TestCase
  setup do
    @spider = ProfileSpider.new
    # Setup first profile page information
    @profile_page_1 = open("test/assets/example_with_all_profile_fields.html")
    @source_code_1 = Nokogiri::HTML(@profile_page_1)
    @container_1 = @source_code_1.xpath("//div[@class='h-card mt-4 mt-md-n5']")
    @username_1 = "guiaugusto"
    # Setup second profile page information
    @profile_page_2 = open("test/assets/example_without_org_and_location_fields.html")
    @source_code_2 = Nokogiri::HTML(@profile_page_2)
    @container_2 = @source_code_2.xpath("//div[@class='h-card mt-4 mt-md-n5']")
  end
  
  test "should get successfully the profile github username" do
    github_username = @spider.send(:github_username, @container_1)
    assert github_username == "guiaugusto"
  end

  test "should get successfully the profile github image url" do
    github_profile_image = @spider.send(:github_profile_image, @container_1)
    assert github_profile_image
  end

  test "should get successfully the profile organization" do
    organization = @spider.send(:organization, @container_1)
    assert github_profile_image = "@lappisunb"
  end

  test "should get empty organization" do
    organization = @spider.send(:organization, @container_2)
    assert organization.empty?
  end
  
  test "should get successfully the profile location" do
    location = @spider.send(:location, @container_1)
    assert location == "Brasília - Brazil"
  end

  test "should get empty location" do
    location = @spider.send(:location, @container_2)
    assert location.empty?
  end

  test "should get successfully the profile amount of followers" do
    amount_of_followers = @spider.send(:amount_of_followers, @container_1, @username_1)
    assert amount_of_followers.is_a? Integer
  end

  test "should get successfully the profile amount of following" do
    amount_of_following = @spider.send(:amount_of_following, @container_1, @username_1)
    assert amount_of_following.is_a? Integer
  end

  test "should get successfully the profile amount of stars" do
    amount_stars = @spider.send(:amount_stars, @container_1, @username_1)
    assert amount_stars.is_a? Integer
  end

  test "should get successfully the profile contributions" do
    amount_contributions = @spider.send(:amount_contributions, @container_1)
    assert amount_contributions.is_a? Integer
  end

end

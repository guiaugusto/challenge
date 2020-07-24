require 'nokogiri'
require 'open-uri'

class ProfileSpider

  def self.scrape(url, profile_name)
    profile_params = {}
    source_code = Nokogiri::HTML(URI.open(url))
    container = source_code.xpath("//div[@class='h-card mt-4 mt-md-n5']")

    profile_params[:profile_name] = profile_name
    profile_params[:github_address] = url
    profile_params[:github_username] = container.css("span[@class='p-nickname vcard-username d-block']")&.text&.squish
    
    github_profile_url = container.css("img[@class='avatar avatar-user width-full border bg-white']").attr('src').text&.squish
    profile_params[:github_profile_image] = Client.instance.bitly_client.shorten(long_url: github_profile_url).link

    profile_params[:organization] = container.css("span[@class='p-org']").css("a[@class='user-mention']")&.text&.squish
    profile_params[:location] = container.css("span[@class='p-label']")&.text&.squish

    followers = container.css("a[@href='/#{profile_params[:github_username]}?tab=followers']")
    following = container.css("a[@href='/#{profile_params[:github_username]}?tab=following']")
    stars = container.css("a[@href='/#{profile_params[:github_username]}?tab=stars']")
    contributions_desc = source_code.xpath("//div[@class='js-yearly-contributions']")

    profile_params[:amount_of_followers] = followers.css("span[@class='text-bold text-gray-dark']")&.text&.squish.to_i
    profile_params[:amount_of_following] = following.css("span[@class='text-bold text-gray-dark']")&.text&.squish.to_i
    profile_params[:amount_stars] = stars.css("span[@class='text-bold text-gray-dark']")&.text&.squish.to_i

    amount_of_contributions = contributions_desc.css("h2[@class='f4 text-normal mb-2']")&.text&.squish
    profile_params[:amount_contributions] = amount_of_contributions.scan(/\d+/).first.to_i

    profile_params
  end

end
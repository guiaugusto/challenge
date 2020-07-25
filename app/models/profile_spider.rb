require 'nokogiri'
require 'open-uri'

class ProfileSpider

  def scrape(url, profile_name)
    profile_params = {}
    source_code = Nokogiri::HTML(URI.open(url))
    container = source_code.xpath("//div[@class='h-card mt-4 mt-md-n5']")

    github_username = github_username(container)

    profile_params = {
      profile_name: profile_name,
      github_address: url,
      github_username: github_username,
      github_profile_image: github_profile_image(container),
      organization: organization(container),
      location: location(container),
      amount_of_followers: amount_of_followers(container, github_username),
      amount_of_following: amount_of_following(container, github_username),
      amount_stars: amount_stars(container, github_username),
      amount_contributions: amount_contributions(source_code)
    }

    profile_params
  end

  private
  
  def github_username(container)
    container.css(
      "span[@class='p-nickname vcard-username d-block']"
    )&.text&.squish
  end

  def github_profile_image(container)
    github_profile_url = container.css(
      "img[@class='avatar avatar-user width-full border bg-white']"
    ).attr('src').text&.squish
    Client.instance.bitly_client.shorten(long_url: github_profile_url).link
  end

  def organization(container)
    container.css(
      "a[@class='user-mention']"
    )&.text&.squish
  end

  def location(container)
    container.css("span[@class='p-label']")&.text&.squish
  end

  def amount_of_followers(container, github_username)
    followers = container.css(
      "a[@href='/#{github_username}?tab=followers']"
    )
    followers.css(
      "span[@class='text-bold text-gray-dark']"
    )&.text&.squish.to_i
  end
    
  def amount_of_following(container, github_username)
    following = container.css(
      "a[@href='/#{github_username}?tab=following']"
    )
    following.css(
      "span[@class='text-bold text-gray-dark']"
    )&.text&.squish.to_i
  end

  def amount_stars(container, github_username)
    stars = container.css(
      "a[@href='/#{github_username}?tab=stars']"
    )
    stars.css(
      "span[@class='text-bold text-gray-dark']"
    )&.text&.squish.to_i
  end

  def amount_contributions(container)
    amount_of_contributions = container.xpath(
      "//div[@class='js-yearly-contributions']"
    ).css(
      "h2[@class='f4 text-normal mb-2']"
    )&.text&.squish
    amount_of_contributions.scan(/\d+/).first.to_i
  end

end
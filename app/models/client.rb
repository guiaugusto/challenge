require 'singleton'

class Client
  include Singleton
  
  def bitly_client
    @client = Bitly::API::Client.new(token: ENV["bitly_token"])
  end
end
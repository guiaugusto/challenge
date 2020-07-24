class ApplicationController < ActionController::Base
  def home
    @profiles = Profile.none
    render 'layouts/home'
  end
end
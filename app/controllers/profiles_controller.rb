class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.search(params[:search])
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    params = scrape(profile_params)
    @profile = Profile.new(params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    params = scrape(profile_params)
    respond_to do |format|
      if @profile.update(params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def scan
    if set_profile
      profile_params = scrape({ github_address: @profile.github_address, profile_name: @profile.profile_name })
      if @profile.update(profile_params)
        redirect_to action: 'show', notice: 'Profile was successfully updated.'
      else
        redirect_to action: 'show', notice: 'An error occuried trying to rescan profile values.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(
        :profile_name,
        :github_address,
        :github_username,
        :amount_of_followers,
        :amount_of_following,
        :amount_stars,
        :amount_contributions,
        :github_profile_image,
        :organization,
        :location,
        :search
      )
    end

    def scrape(params)
      spider = ProfileSpider.new
      response = spider.scrape(params[:github_address], params[:profile_name])
    rescue => e
      puts("Error: #{e}")
    end

end

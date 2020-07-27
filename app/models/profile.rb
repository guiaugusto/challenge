class Profile < ApplicationRecord
  include PgSearch::Model

  validates :profile_name, :github_profile_image, presence: true
  validates :github_username, :github_address, uniqueness: true

  pg_search_scope :search_by_term, against: [:profile_name, :github_username, :organization, :location],
                    using: {
                      tsearch: {
                        any_word: true,
                        prefix: true
                      }
                    }

  def self.search(query)
    if query.nil? or query.empty?
      @profiles = Profile.all
    else
      @profiles = Profile.search_by_term(query)
    end
  end

end

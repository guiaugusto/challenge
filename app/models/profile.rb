class Profile < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_term, against: [:profile_name, :github_username],
                    using: {
                      tsearch: {
                        any_word: true,
                        prefix: true
                      }
                    }

  def self.search(query)
    if query.present? and !query[:search].empty?
      @profiles = Profile.search_by_term(query[:search])
    else
      @profiles = Profile.all
    end
  end

end

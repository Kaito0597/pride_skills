class Character < ApplicationRecord

    belongs_to :user
    has_many :skills
    has_many :ability_scores

end

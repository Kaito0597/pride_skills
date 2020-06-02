class Character < ApplicationRecord

    belongs_to :user
    belongs_to :game
    has_many :skills
    has_many :ability_scores

end

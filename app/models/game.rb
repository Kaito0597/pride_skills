class Game < ApplicationRecord

    has_many :player_data
    has_many :users, through: :player_data
    has_many :characters

end

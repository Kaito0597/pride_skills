class User < ApplicationRecord

    has_secure_password
    has_many :characters, dependent: :destroy
    has_many :player_data
    has_many :games, through: :player_data

end

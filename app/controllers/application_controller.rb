class ApplicationController < ActionController::Base

    before_action :authorized, :only => [:home, :configuration]

    helper_method :current_user
    helper_method :logged_in?

    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized
        unless logged_in?
            redirect_to login_path
        end
    end

    def home
        @user = current_user
        @characters = current_user.characters

        if @user.selected_character_id != nil
            @character = Character.find_by(:id => @user.selected_character_id)
            @skills = @character.skills
            @ability_scores = @character.ability_scores
        end
    end

    def change_character
        user = current_user
        user.selected_character_id = params[:id]
        user.save
        
        redirect_to root_path
    end

    def configuration
        @user = current_user
        @character = Character.find_by(:id => @user.selected_character_id)
        @skills = @character.skills
        @ability_scores = @character.ability_scores
        @class_dict = {
            :Barbarian => 2,
            :Bard => 3,
            :Cleric => 2,
            :Druid => 2,
            :Fighter => 2,
            :Monk => 2,
            :Paladin => 2,
            :Ranger => 3,
            :Rogue => 4,
            :Sorcerer => 2,
            :Warlock => 2,
            :Wizard => 2,
            :Artificer => 3,
            :BloodHunter => 2,
            :Alchemist => 3,
            :Summoner => 2
        }
    end

    def login
    end

    def register
        @user = User.new()
    end

end

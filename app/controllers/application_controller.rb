class ApplicationController < ActionController::Base

    before_action :logged_in, :except => [:login, :register, :create]
    before_action :set_user

    def logged_in
        if session[:user_id] == nil
            redirect_to login_path
        end
    end

    def welcome
        @game = Game.new()
    end

    def home
        @game = Game.find_by(:id => @user.selected_game_id)

        if @user.selected_game_id != nil
            @player_data = @game.player_data.find_by(:user_id => @user.id)
            @selected_game = Game.find_by(:id => @user.selected_game_id)

            @character = Character.find_by(:id => Game.find_by(:id => @user.selected_game_id).player_data.find_by(:user_id => @user.id).selected_character_id)
            if @player_data.is_gamemaster
                @characters = @game.characters
            else
                @characters = Character.where(:user_id => @user.id, :game_id => @selected_game.id)
            end

            if @character != nil
                @skills = @character.skills
                @ability_scores = @character.ability_scores
            end
        else
            redirect_to welcome_path
        end
    end

    def change_character
        @user = User.find_by(:id => User.find_by(:id => session[:user_id]))
        @user.player_data.find_by(:game_id => user.selected_game_id).update(:selected_character_id => params[:id])
        
        redirect_to root_path
    end

    def configuration
        @character = Character.find_by(:id => @user.player_data.find_by(:game_id => @user.selected_game_id).selected_character_id)
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

    def ingame_date
        @game = Game.find_by(:id => @user.selected_game_id)
    end 

    def about
    end

    def login
    end

    def register
        @user = User.new()
    end

    private
    
    def set_user
        @user = User.find_by(id: session[:user_id])
    end

end

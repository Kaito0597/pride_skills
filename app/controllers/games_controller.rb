class GamesController < ApplicationController

    require 'securerandom'

    def create
        user = User.find_by(:id => session[:user_id])
        @game = Game.new(game_params)
        random_join_code = SecureRandom.alphanumeric(7)

        while Game.find_by(:join_code => random_join_code) != nil do
            random_join_code = SecureRandom.alphanumeric(7)
        end

        @game.join_code = random_join_code
        if @game.save
            PlayerDatum.create(:user_id => user.id, :game_id => @game.id, :is_gamemaster => true)
            user.update(:selected_game_id => @game.id)
            redirect_to root_path
        end
    end
    
    def joinGame
        user = User.find_by(:id => session[:user_id])
        game = Game.find_by(:join_code => params[:game_code])

        if game != nil
            user.selected_game_id = game.id
            user.save()
            game.player_data.create(:user_id => user.id, :game_id => game.id)
        end
    end

    def change_game
        @user = User.find_by(:id => session[:user_id])
        @games = @user.games

        if params[:game_id] != nil
            @user.update(:selected_game_id => params[:game_id])
        end
    end
    
    def changeDate
        game = Game.find_by(:id => params[:game_id])
        game.ingame_datetime = params[:date]

        respond_to do |format|
            format.html
            format.json {render :json => {:new_date => game.ingame_datetime.strftime("%A, %B #{game.ingame_datetime.day.ordinalize} %Y")}}
        end

        game.save()
    end

    def incrementDateByOne
        game = Game.find_by(:id => params[:game_id])
        game.ingame_datetime = game.ingame_datetime + 1.days

        respond_to do |format|
            format.html
            format.json {render :json => {:new_date => game.ingame_datetime.strftime("%A, %B #{game.ingame_datetime.day.ordinalize} %Y")}}
        end

        game.save()
    end

    def decrementDateByOne
        game = Game.find_by(:id => params[:game_id])
        game.ingame_datetime = game.ingame_datetime - 1.days

        respond_to do |format|
            format.html
            format.json {render :json => {:new_date => game.ingame_datetime.strftime("%A, %B #{game.ingame_datetime.day.ordinalize} %Y")}}
        end

        game.save()
    end

    private

    def set_game
        @game = Game.find_by(params[:id])
    end

    def game_params
        params.require(:game).permit(:name)
    end

end
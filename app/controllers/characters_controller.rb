class CharactersController < ApplicationController

    before_action :set_character

    def new
        @character = Character.new()
    end

    def create
        ability_scores = [['Strength', 'STR'], ['Dexterity', 'DEX'], ['Constitution', 'CON'], ['Intelligence', 'INT'], ['Wisdom', 'WIS'], ['Charisma', 'CHA']]
        
        skills = [['Acrobatics', 'DEX'], ['Animal Handling', 'WIS'], ['Arcana', 'INT'], ['Athletics', 'STR'], ['Deception', 'CHA'], ['History', 'INT'],
              ['Insight', 'WIS'], ['Intimidation', 'CHA'], ['Investigation', 'INT'], ['Medicine', 'WIS'], ['Nature', 'INT'], ['Perception', 'WIS'],
              ['Performance', 'CHA'], ['Persuasion', 'CHA'], ['Religion', 'INT'], ['Sleight of Hand', 'DEX'], ['Stealth', 'DEX'], ['Survival', 'WIS']]

        @character = Character.new(character_params)
        @character.user = User.find_by(:id => session[:user_id])
        @character.game = Game.find_by(:id => User.find_by(:id => session[:user_id]).selected_game_id)

        if @character.save!
            skills_records = []
            for skill in skills do
                new_skill = @character.skills.build(:name => skill[0], :ability_score => skill[1])
                skills_records << new_skill     
            end
            Skill.import skills_records

            ability_scores_records = []
            for ability_score in ability_scores do
                new_ability_score = @character.ability_scores.build(:name => ability_score[0], :abbreviation => ability_score[1])
                ability_scores_records << new_ability_score
            end
            AbilityScore.import ability_scores_records
        end

        @user = @character.user
        @user.player_data.find_by(:game_id => Game.find_by(:id => @user.selected_game_id)).selected_character_id = @character.id
        user_player_data = @user.player_data.find_by(:game_id => Game.find_by(:id => @user.selected_game_id))
        user_player_data.selected_character_id = @character.id
        user_player_data.save
        @user.save()

        redirect_to root_path

    end

    def update
        skills_records = []
        @character.skills.each do |skill|
            skill.score = params[skill.name + "-score"]
            skill.points_invested = params[skill.name + "-points"]
            skill.expertise = params[skill.name + "-expertise"]
            skill.proficiency = params[skill.name + "-prof"]
            skills_records << skill
        end
        Skill.import skills_records, on_duplicate_key_update: [:score, :points_invested, :expertise, :proficiency]

        ability_scores_records = []
        @character.ability_scores.each do |ability_score|
            ability_score.score = params[ability_score.abbreviation]
            ability_scores_records << ability_score
        end
        AbilityScore.import ability_scores_records, on_duplicate_key_update: [:score]

        @character.class_name = params["Class"]
        @character.level = params["Level"]
        @character.jack_of_all_trades = params["joat"]
        @character.skill_points = params["SkillPoints"]

        @character.save
    end

    def destroy
        character = Character.find_by(:id => params[:id])
        user = User.find_by(:id => session[:user_id])
        character.destroy
        if character.id == user.player_data.find_by(:game_id => @user.selected_game_id).selected_character_id
            if user.characters.where(:game_id => @user.selected_game_id).first != nil
                user.player_data.find_by(:game_id => @user.selected_game_id).update(selected_character_id: user.characters.first.id)
            else
                user.player_data.find_by(:game_id => @user.selected_game_id).update(selected_character_id: nil)
            end
        end
    end

    private

    def set_character
        @user = User.find_by(:id => User.find_by(:id => session[:user_id]))
        @character = Character.find_by(:id => Game.find_by(:id => @user.selected_game_id).player_data.find_by(:user_id => @user.id).selected_character_id)
    end

    def character_params
        params.require(:character).permit(:name)
    end

end
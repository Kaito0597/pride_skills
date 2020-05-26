class UsersController < ApplicationController

    before_action :set_user

    def create
    
        ability_scores = [['Strength', 'STR'], ['Dexterity', 'DEX'], ['Constitution', 'CON'], ['Intelligence', 'INT'], ['Wisdom', 'WIS'], ['Charisma', 'CHA']]
        
        skills = [['Acrobatics', 'DEX'], ['Animal Handling', 'WIS'], ['Arcana', 'INT'], ['Athletics', 'STR'], ['Deception', 'CHA'], ['History', 'INT'],
              ['Insight', 'WIS'], ['Intimidation', 'CHA'], ['Investigation', 'INT'], ['Medicine', 'WIS'], ['Nature', 'INT'], ['Perception', 'WIS'],
              ['Performance', 'CHA'], ['Persuasion', 'CHA'], ['Religion', 'INT'], ['Sleight of Hand', 'DEX'], ['Stealth', 'DEX'], ['Survival', 'WIS']]

        @user = User.new(user_params)

        if @user.save
            # character = @user.characters.create()
            
            # skills_records = []
            # for skill in skills do
            #     new_skill = character.skills.build(:name => skill[0], :ability_score => skill[1])
            #     skills_records << new_skill     
            # end
            # Skill.import skills_records

            # ability_scores_records = []
            # for ability_score in ability_scores do
            #     new_ability_score = character.ability_scores.build(:name => ability_score[0], :abbreviation => ability_score[1])
            #     ability_scores_records << new_ability_score
            # end
            # AbilityScore.import ability_scores_records

            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to register_path
        end
        
    end

    private

    def set_user
        @user = User.find_by(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
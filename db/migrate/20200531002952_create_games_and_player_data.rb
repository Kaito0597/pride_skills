class CreateGamesAndPlayerData < ActiveRecord::Migration[6.0]

  def change
    create_table :games do |t|
      t.string :name
      t.string :join_code
      t.date :ingame_datetime, :default => Time.zone.now.to_date
    end

    create_table :player_data do |t|
      t.belongs_to :user
      t.belongs_to :game

      t.boolean :is_gamemaster, :default => false
      t.integer :selected_character_id
    end
  end
end

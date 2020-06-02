class AddSelectedGameIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :selected_game_id, :string
  end
end

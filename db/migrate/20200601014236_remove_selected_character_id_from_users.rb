class RemoveSelectedCharacterIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :selected_character_id, :string
  end
end

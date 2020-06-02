class AddGameIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :characters, :game
  end
end

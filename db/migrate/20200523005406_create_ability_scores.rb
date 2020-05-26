class CreateAbilityScores < ActiveRecord::Migration[6.0]
  def change
    create_table :ability_scores do |t|

      t.belongs_to :character

      t.string :name
      t.string :abbreviation
      t.integer :score, :default => 10

    end
  end
end

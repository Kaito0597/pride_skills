class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|

      t.belongs_to :character
      t.string :name
      t.string :ability_score
      t.integer :score, :default => 0
      t.integer :points_invested, :default => 0
      t.boolean :expertise, :default => false
      t.boolean :proficiency, :default => false

    end
  end
end

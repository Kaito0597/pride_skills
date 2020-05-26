class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|

      t.belongs_to :user 

      t.string :name
      t.string :class_name, :default => 'Barbarian'
      t.integer :level, :default => 1
      t.integer :skill_points, :default => 0
      t.boolean :jack_of_all_trades, :default => false
      
    end
  end
end

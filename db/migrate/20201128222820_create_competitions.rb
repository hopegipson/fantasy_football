class CreateCompetitions < ActiveRecord::Migration[6.0]
  def change
    create_table :competitions do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :game_id
      t.integer :game_week

      t.timestamps
    end
  end
end

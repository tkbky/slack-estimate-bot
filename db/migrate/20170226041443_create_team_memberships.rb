class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :team_memberships, [:user_id, :team_id], unique: true
  end
end

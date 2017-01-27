class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :point, null: false, default: 0
      t.references :story, index: true, foreign_key: true
      t.string :user_slack_id, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps null: false
    end

    add_index :estimates, [:user_slack_id, :story_id], unique: true
  end
end

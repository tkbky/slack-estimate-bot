class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :slack_id, null: false
      t.string :name, null: false
      t.string :incoming_webhook_url, null: false
      t.string :incoming_webhook_channel, null: false
      t.string :incoming_webhook_config_url, null: false
      t.string :bot_user_id, null: false, default: ''
      t.string :bot_access_token, null: false, default: ''
      t.string :access_token, null: false
      t.string :scope, null: false

      t.timestamps null: false
    end

    add_index :teams, [:slack_id, :incoming_webhook_channel], unique: true
  end
end

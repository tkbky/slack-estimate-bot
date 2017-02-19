class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :slack_id, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :slack_id, unique: true
  end
end

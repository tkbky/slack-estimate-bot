class AddUuidToEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :uuid, :uuid, null: false, default: 'uuid_generate_v4()'
    add_index :estimates, :uuid, unique: true
  end
end

class CreateTableLockModels < ActiveRecord::Migration
  def change
    create_table :table_lock_models do |t|
      t.timestamps null: false
    end
  end
end

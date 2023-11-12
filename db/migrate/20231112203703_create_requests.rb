class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :status, default: 0
      t.references :availability, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

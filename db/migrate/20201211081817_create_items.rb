class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :items, [:user_id, :created_at]
  end
end

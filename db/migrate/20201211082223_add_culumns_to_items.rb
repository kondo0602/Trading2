class AddCulumnsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :shitagaki, :integer, default: '0'
    add_column :items, :brand, :string
    add_column :items, :size, :string
    add_column :items, :status, :string
  end
end

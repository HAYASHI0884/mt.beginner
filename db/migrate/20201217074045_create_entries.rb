class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :user, null: false
      t.references :room, null: false
      t.timestamps
    end
  end
end

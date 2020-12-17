class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text       :text, null: false
      t.references :user, null: false
      t.references :room, null: false
      t.timestamps
    end
  end
end

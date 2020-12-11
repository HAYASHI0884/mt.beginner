class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string     :title,        null: false
      t.text       :introduction, null: false
      t.string     :area
      t.string     :elevation
      t.references :user,         null: false

      t.timestamps
    end
  end
end

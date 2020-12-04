class CreateMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains do |t|
      t.string  :name,       null: false
      t.integer :area,       null: false
      t.integer :elevation,  null: false
      t.integer :climb_time, null: false

      t.timestamps
    end
  end
end

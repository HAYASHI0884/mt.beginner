class CreateMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains do |t|
      t.string  :name,       null: false
      t.references :area,       null: false
      t.references :elevation,  null: false
      t.references :climb_time, null: false

      t.timestamps
    end
  end
end

class CreateMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains do |t|

      t.timestamps
    end
  end
end

class CreateAttendants < ActiveRecord::Migration[5.0]
  def change
    create_table :attendants do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
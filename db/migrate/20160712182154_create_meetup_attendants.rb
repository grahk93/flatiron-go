class CreateMeetupAttendants < ActiveRecord::Migration[5.0]
  def change
    create_table :meetup_attendants do |t|
      t.integer :meetup_id
      t.integer :attendant_id

      t.timestamps
    end
  end
end

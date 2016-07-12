class CreateMeetups < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |t|
      t.date :date
      t.time :time
      t.text :description
      t.integer :location_id
      t.integer :host_id

      t.timestamps
    end
  end
end

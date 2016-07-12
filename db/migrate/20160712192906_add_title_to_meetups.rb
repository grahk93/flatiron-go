class AddTitleToMeetups < ActiveRecord::Migration[5.0]
  def change
    add_column :meetups, :title, :string
  end
end

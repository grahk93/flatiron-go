FactoryGirl.define do
  factory :meetup do
    title "Pokemon Go Expedition!"
    description "gotta catch 'em all!"
    set_date Date.today
    set_hour_min Time.now
  end
end
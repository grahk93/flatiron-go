FactoryGirl.define do
  factory :meetup do
    title "Pokemon Go Expedition!"
    description "gotta catch 'em all!"
    date Date.today
    time Time.now.hour
  end
end
require 'rails_helper'

describe "As a registered user" do
  context 'they visit /trips-dashboard' do
    it 'they should show longest and shortest ride' do
      user = User.create!(username: "Pat", password: "test", address: '123 Main st', first_name: 'Pat', last_name: 'Rat')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station_1 = Station.create!(name: 'Wads', dock_count: 15, city: 'Lakewood', installation_date: Time.now)
      station_2 = Station.create!(name: 'Fed Center', dock_count: 10, city: 'Golden', installation_date: Time.now)
      trip_1 = Trip.create!(duration: 60,
                            start_date: Date.parse("2017-10-29"),
                            start_station_id: station_1.id,
                            end_date: Date.parse("2017-11-29"),
                            end_station_id: station_2.id,
                            bike_id: 1,
                            subscription_type: 'monthly',
                            zip_code: 80222
                          )
      trip_2 = Trip.create!(duration: 50,
                            start_date: Date.parse("2017-10-29"),
                            start_station_id: station_2.id,
                            end_date: Date.parse("2017-11-29"),
                            end_station_id: station_1.id,
                            bike_id: 2,
                            subscription_type: 'stolen',
                            zip_code: 90210
                          )
      trip_3 = Trip.create!(duration: 55,
                            start_date: Date.parse("2017-08-25"),
                            start_station_id: station_2.id,
                            end_date: Date.parse("2017-11-29"),
                            end_station_id: station_2.id,
                            bike_id: 2,
                            subscription_type: 'stolen',
                            zip_code: 90210
                          )
    condition_1 = Condition.create!(date: Date.parse('2017-10-29'),
                                    max_temp: 12.3,
                                    mean_temp: 56.0,
                                    min_temp:1.0,
                                    mean_humidity: 30.0,
                                    mean_visibility: 3.0,
                                    mean_windspeed: 10.0,
                                    precipitation: 2.0
                                  )
    condition_2 = Condition.create!(date: Date.parse('2017-08-25'),
                                    max_temp: 22.1,
                                    mean_temp: 45.0,
                                    min_temp:5.0,
                                    mean_humidity: 70.0,
                                    mean_visibility: 14.0,
                                    mean_windspeed: 12.5,
                                    precipitation: 5.0
                                  )

      visit trips_dashboard_path

      expect(page).to have_content("Longest Ride: #{trip_1.duration} minutes from #{trip_1.start_station.name} to #{trip_1.end_station.name} on #{trip_1.start_date}")
      expect(page).to have_content("Shortest Ride: #{trip_2.duration} minutes from #{trip_2.start_station.name} to #{trip_2.end_station.name} on #{trip_2.start_date}")
    end
  end
end

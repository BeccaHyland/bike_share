class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_date,
                        :end_station_id,
                        :bike_id,
                        :subscription_type,
                        :zip_code

  def start_station_name(trip)
    Station.find(trip.start_station_id).name
  end

  def end_station_name(trip)
    Station.find(trip.end_station_id).name
  end
end

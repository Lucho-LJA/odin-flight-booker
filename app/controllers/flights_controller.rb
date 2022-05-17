class FlightsController < ApplicationController
  def index
    @departure_airport = params[:departure_airport_id]
    @arrival_airport = params[:arrival_airport_id]
    
    @passenger_count = params[:passenger_count]
    unless @departure_airport.blank? and @arrival_airport.blank?
      @start_datetime = Date.parse(params[:start_datetime])
      @flights = Flight.all.where(
        departure_airport_id: @departure_airport,
        arrival_airport_id: @arrival_airport,
        start_datetime: (@start_datetime..@start_datetime+1.day)
      ).order(:start_datetime)
      p @flights
    else
      @flights = nil
    end
    @airports = Airport.all.order("city").map{ |a| [ a.city, a.id ] }
  end

  def new
  end
end

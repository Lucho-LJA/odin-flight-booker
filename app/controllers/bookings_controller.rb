class BookingsController < ApplicationController
    def new
        @booking1=Booking.new(permit_params1)
        @booking = Booking.new
        times_pb = params[:booking][:tickets].to_i
        times_pb.times { @booking.passengers.build }
    end
    def show
        @booking = Booking.find(params[:id])
        @passenger = []
        @pb = PassengerBooking.all.where(booking_id:@booking.id)
        @pb.each do |pass|
            @passenger.append(Passenger.find(pass.passenger_id))
        end
        @flight = Flight.find(@booking.flight_id)
    end
    
    def create
        @booking = Booking.new(permit_params2)
        p "okoo"
        permit_params3[:passengers_attributes].each do |pas|
            pass_aux = Passenger.all.where(email:pas[1][:email])
            if pass_aux.any?
                p_id = pass_aux[0].id
                if pass_aux[0].name == pas[1][:name]
                    if @booking.save
                       @pb = @booking.passenger_bookings.build(passenger_id:p_id)
                       @pb.save
                    end
                else
                    p "Error of name"
                    break
                end
            else
                @pass = Passenger.new(pas[1])
                if @pass.save
                    if @booking.save
                        @pb = @booking.passenger_bookings.build(passenger_id:@pass.id)
                        @pb.save
                     end
                end
            end

        end
        redirect_to @booking
    end

        

        
    def permit_params1
        params.require(:booking).permit(:flight_id, :tickets)
    end
    def permit_params
        params.require(:booking).permit(:flight_id, :tickets, 
            :confirmation_number, passengers_attributes:[:name, :email])
    end
    def permit_params2
        params.require(:booking).permit(:flight_id, :tickets, 
            :confirmation_number)
    end
    def permit_params3
        params.require(:booking).permit(passengers_attributes:[:name, :email])
    end
end

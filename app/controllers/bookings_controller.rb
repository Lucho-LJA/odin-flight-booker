class BookingsController < ApplicationController
    def index
        @opc = params[:option]
        @opc_find= params[:opc_find]
    
        unless @opc.blank? and @opc_find.blank?
            if @opc == "Ticket"
                @tickets = Booking.all.where(confirmation_number:@opc_find)
            else
                pass_aux = Passenger.where(email: @opc_find)[0]
                book_aux = PassengerBooking.all.where(passenger_id: pass_aux.id)
                @tickets = []
                book_aux.each do |book|
                    @tickets.append(Booking.find(book.booking_id))
                end
            end
            @booking=Booking.new
        else
                @tickets = nil
                @booking = nil
        end

    end

    def new
        @booking1=Booking.new(permit_params1)
        @booking = Booking.new
        times_pb = params[:booking][:tickets].to_i
        times_pb.times { @booking.passengers.build }
    end
    def show
        p "oonpnobonon"
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
        permit_params3[:passengers_attributes].each do |pas|
            pass_aux = Passenger.all.where(email:pas[1][:email])
            if pass_aux.any?
                p_id = pass_aux[0].id
                if pass_aux[0].name == pas[1][:name]
                    if @booking.save
                       @pb = @booking.passenger_bookings.build(passenger_id:p_id)
                       @pb.save
                       @correct = true
                    end
                    
                else
                    flash[:alert] = "One o more names already have a email assigned"
                    p "Error of name"
                    redirect_to new_booking_path({booking:{flight_id:params[:booking][:flight_id], 
                        tickets:params[:booking][:tickets]}})
                    break
                end
            else
                @pass = Passenger.new(pas[1])
                if @pass.save
                    if @booking.save
                        @pb = @booking.passenger_bookings.build(passenger_id:@pass.id)
                        @pb.save
                     end
                     @correct = true
                end
            end
            unless @correct.blank?
                @params_email = {name:pas[1][:name], email:pas[1][:email],
                ticket: params[:booking][:confirmation_number]}
                PassengerMailer.with(user: @params_email).confirmation_email.deliver_later
            end       
        end
        redirect_to @booking unless @correct.blank?
        p "blblbksbisvudvy"
        p @correct
    end

    def edit
        @booking = Booking.find(params[:id])
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

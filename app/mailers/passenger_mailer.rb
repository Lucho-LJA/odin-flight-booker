class PassengerMailer < ApplicationMailer
    default from: 'aasctronix.info@gmail.com'
    
    def confirmation_email
        p "looookkokokokokokoko"
        p params[:user]
        @user = params[:user]
        @url = 'http://localhost:3000'
        mail(to:@user[:email], subject:'Tickect reserved')
    end
end

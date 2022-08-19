class ApplicationController < ActionController::Base
    include SessionsHelper
    def hello
        #render html: "Hello, world!"
        #render html: "Hola, mundo!"
        render html: "¡Hola, mundo!"
    end

    private
        # Confirms a logged-in user.
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
end

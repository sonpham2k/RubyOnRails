class ApplicationController < ActionController::Base
    include SessionsHelper
    def hello
        #render html: "Hello, world!"
        #render html: "Hola, mundo!"
        render html: "¡Hola, mundo!"
    end
end

class UsersController < ApplicationController

    
    # users can sign up
    get '/signup' do
        erb :'users/signup'
    end
    
    post '/signup' do
        user = User.new(params)
        if user.username&.empty? || user.password_digest&.empty?
            @error = "Please enter a valid username and password."
            erb :'users/signup'
        elsif User.find_by(username: user.username)
            @error = "That username is unavailable."
            erb :'users/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect '/events'
        end
    end
 
 end
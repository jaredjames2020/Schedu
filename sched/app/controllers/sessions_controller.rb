class SessionsController < ApplicationController

    # user to log in
    get '/login' do
        erb :'users/login'
    end
    
    post '/login' do
        if params[:username].empty? || params[:password].empty?
            @error = "Please enter a valid username and password."
            erb :'users/login' 
        else
            if user = User.find_by(username: params[:username]) 
                if user && user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect '/events'
                end
            else
                @error = "Account not found"
                erb :'users/login'
            end
        end
    end
    
    # user to log out
    get '/logout' do
        session.clear
        redirect '/'
    end

end
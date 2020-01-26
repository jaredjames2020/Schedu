class EventsController < ApplicationController

    before do
        require_login
    end

   #CREATE
        #new - make a get request to '/events/new'
        get '/events/new' do
            erb :'events/new'
        end

        #create - make a post request to '/events'
        post '/events' do
            events = Event.new(params[:event])
            events.user_id = session[:user_id]
            if events.save
                if params[:notes][:entry] != nil
                    notes = Note.new(entry: params[:notes][:entry], event_name: params[:event][:event_name])
                    notes.event = events
                    notes.save
                    events.notes_id = notes.id
                    events.save
                    #User.find_by(id: session[:user_id]).events.build(params)
                end
                redirect '/events'
            else
                erb :'events/new'
            end
        end

    #READ
        #index - make a get request to '/events'
        get '/events' do
            if logged_in?
                @events = Event.all.reverse
                erb :'events/index'
            else
                redirect '/'
            end
        end

        #show - make a get request to '/events/:id'
        get '/events/:id' do
            if logged_in?
                @events = Event.find_by(id: params[:id])
                @notes = Note.find_by(event_id: params[:id])
                    if @events
                        erb :'events/show'
                    else
                        #@error = "This event does not exist." Display error
                        redirect '/events'
                    end
            else
                redirect '/login'
            end
        end

    #UPDATE
        #edit - make a get request to '/events/:id/edit'
        get '/events/:id/edit' do
            @events = Event.find(params[:id])
            @notes = Note.find_by(event_id: params[:id])
            erb :'events/edit'
        end

        #update - make a patch request to '/events/:id'
        patch '/events/:id' do
            events = Event.find(params[:id])
            notes = Note.find_by(event_id: params[:id])
            events.update(params[:event])
            notes.update(params[:notes])
            redirect "/events"
        end

    #DELETE
        #destroy - make a delete request to '/events/:id'
        delete '/events/:id' do
            events = Event.find(params[:id])
            events.destroy
            redirect '/events'
        end

end

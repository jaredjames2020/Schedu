class NotesController < ApplicationController

    before do
        require_login
    end

    #CREATE
        #new - make a get request to '/notes/new'
        get '/notes/new' do
            erb :'notes/new'
        end

        #create - make a post request to '/notes'
        post '/notes' do
            notes = Note.new(entry: params[:notes][:entry], event_name: params[:notes][:event_name], user_id: current_user.id)
            events = Event.new(notes_id: notes.id, event_name: notes.event_name, user_id: current_user.id)
            if notes.save
                events.save
                notes.event = events
                events.notes_id = notes.id
                notes.save
                events.save
            redirect '/notes'
            else
                erb :'notes/new'
            end
        end

    #READ
        #index - make a get request to '/notes'
        get '/notes' do
            @notes = Note.all.reverse
            @events = Event.all.reverse
            erb :'notes/index'
        end 

        #show - make a get request to '/notes/:id'
        get '/notes/:id' do
            @notes = Note.find(params[:id])
            @events = Event.find_by(id: @notes.event_id)
            erb :'notes/show'
        end

    #UPDATE
        #edit - make a get request to '/notes/:id/edit'
        get '/notes/:id/edit' do
            @notes = Note.find(params[:id])
            @events = Event.find(@notes.event_id)
            erb :'/notes/edit'
        end

        #update - make a patch request to '/notes/:id'
        patch '/notes/:id' do
            notes = Note.find(params[:id])
            notes.user_id = current_user.id
            notes.update(params[:notes])
            redirect to '/events/index'
        end

    #DELETE
        #destroy - make a delete request to '/notes/:id'
        delete '/notes/:id' do
            notes = Note.find(params[:id])
            notes.destroy
            redirect '/notes'
        end

end
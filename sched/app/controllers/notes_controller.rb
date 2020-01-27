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
            note = Note.new(entry: params[:notes][:entry], event_name: params[:notes][:event_name], user_id: current_user.id)
            event = Event.new(notes_id: note.id, event_name: note.event_name, user_id: current_user.id)
            if note.save
                event.save
                note.event = event
                event.notes_id = note.id
                note.save
                event.save
            redirect '/notes'
            else
                erb :'notes/new'
            end
        end

    #READ
        #index - make a get request to '/notes'
        get '/notes' do
            @notes = current_user.notes.reverse
            @events = current_user.events.reverse
            erb :'notes/index'
        end

        #show - make a get request to '/notes/:id'
        get '/notes/:id' do
            @note = Note.find(params[:id])
            #@notes.event
            @event = @note.event
            if current_user.id == @note.user_id
              erb :'notes/show'
            else
              redirect '/events'
            end
        end

    #UPDATE
        #edit - make a get request to '/notes/:id/edit'
        get '/notes/:id/edit' do
            @note = Note.find(params[:id])
            @event = @note.event
            if current_user.id == @note.user_id
              erb :'/notes/edit'
            else
              redirect '/events'
            end
        end

        #update - make a patch request to '/notes/:id'
        patch '/notes/:id' do
            note = Note.find(params[:id])
            if current_user.id == note.user_id
              note.update(params[:notes])
              redirect '/events'
            else
              redirect '/events'
          end
        end

    #DELETE
        #destroy - make a delete request to '/notes/:id'
        delete '/notes/:id' do
            note = Note.find(params[:id])
            if current_user.id == note.user_id
              note.destroy
              redirect '/notes'
            else
              redirect '/events'
          end
        end

end

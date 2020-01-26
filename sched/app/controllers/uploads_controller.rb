class UploadsController < ApplicationController

    before do
        require_login
    end

    #CREATE
         #new - make a get request to '/uploads/new'
         get '/uploads' do
            @uploads = Upload.all.reverse
            erb :'uploads/new'
        end

        get '/uploads/all' do
            @uploads = Upload.all.reverse
            erb :'uploads/all'
        end


         #create - make a post request to '/uploads'
         post '/uploads' do
            uploads = Upload.new(entry: params[:upload][":entry"])
            uploads.user_id = current_user.id
            if uploads.save
                redirect '/events'
            else
                erb :'uploads/new'
            end
        end

     #READ
         #index - make a get request to '/uploads'
         get '/uploads' do
            @uploads = Note.all.reverse
            @events = Event.all.reverse
            erb :'uploads/index'
        end

     #DELETE
         #destroy - make a delete request to '/uploads/:id'
         delete '/uploads/:id' do
            uploads = Upload.find(params[:id])
            uploads.destroy
            redirect '/uploads/all'
        end

 end

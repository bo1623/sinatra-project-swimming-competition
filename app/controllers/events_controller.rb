class EventsController < ApplicationController

  get '/events' do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @events=Event.all
    erb :'/events/index' #you could use this page to show the time of the race
  end

  #need to create features to add new events and delete them, registering and signing up for events should be in the swimmers controller
  #maybe make this only a feature available to admin by making the link available to only the admin (e.g. if session[:team_id]==admin.id)
  get '/events/new' do
    erb :'/events/new'
  end

  post '/events' do
    @event=Event.create(params)
    @event.name=@event.make_name
    @event.save
    redirect '/events'
  end

  post '/events/register_swimmer/:slug' do
    @swimmer=Swimmer.find_by_slug(params[:slug])
    @events=@swimmer.events
    @events.each do |event|
      event.timing=params[:swimmer][event.name][:timing]
      event.save
    end
    redirect "/swimmers/#{@swimmer.slug}"
    # when swimmer registers for new event does a new event object get created? is that necessary?
  end

  get '/events/edit' do
    @events=Event.all
    #can select events to edit or delete, only available to admin
  end

  get '/events/:slug' do
    @event=Event.find_by_slug(params[:slug])
    @swimmers=@event.swimmers
    erb :'/events/swimmers'
    #this should show the list of swimmers signed up for this event and their respective teams/times
  end

  # get '/events/register_swimmer' do
  #   erb :'/events/register_swimmer'
  # end


end

#   get "/clubs" do
#     redirect_if_not_logged_in
#     @clubs = GolfClub.all
#     erb :'golf_clubs/index'
#   end
#
#   get "/clubs/new" do
#     redirect_if_not_logged_in
#     @error_message = params[:error]
#     erb :'golf_clubs/new'
#   end
#
#   get "/clubs/:id/edit" do
#     redirect_if_not_logged_in
#     @error_message = params[:error]
#     @club = GolfClub.find(params[:id])
#     erb :'golf_clubs/edit'
#   end
#
#   post "/clubs/:id" do
#     redirect_if_not_logged_in
#     @club = GolfClub.find(params[:id])
#     unless GolfClub.valid_params?(params)
#       redirect "/clubs/#{@club.id}/edit?error=invalid golf club"
#     end
#     @club.update(params.select{|k|k=="name" || k=="manufacturer" || k=="golf_bag_id"})
#     redirect "/clubs/#{@club.id}"
#   end
#
#   get "/clubs/:id" do
#     redirect_if_not_logged_in
#     @club = GolfClub.find(params[:id])
#     erb :'golf_clubs/show'
#   end
#
#   post "/clubs" do
#     redirect_if_not_logged_in
#     unless GolfClub.valid_params?(params)
#       redirect "/clubs/new?error=invalid golf club"
#     end
#     GolfClub.create(params)
#     redirect "/clubs"
#   end

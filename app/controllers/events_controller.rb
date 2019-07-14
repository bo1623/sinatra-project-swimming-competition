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
    signed_up_events=@swimmer.timings.map{|timing| timing.event.name}
    @events.each do |event|
      if signed_up_events.include?(event.name) #if the swimmer has signed up already
        next
      else #if the swimmer hasn't signed up for the event already
        @timing=Timing.create(personal_best: params[:swimmer][event.name][:timing])
        @timing.swimmer=@swimmer
        @timing.event=event
        @timing.save
      end
    end
    redirect "/swimmers/#{@swimmer.slug}"
  end

  get '/events/edit' do #can select events to edit or delete, only available to admin
    @events=Event.all
  end

  get '/events/:slug/edit' do
    erb :'/events/edit'
  end

  get '/events/:slug' do
    @event=Event.find_by_slug(params[:slug])
    @swimmers=@event.swimmers
    erb :'/events/swimmers'
    #this should show the list of swimmers signed up for this event and their respective teams/times
  end

end

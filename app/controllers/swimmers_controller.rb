class SwimmersController < ApplicationController

  get "/swimmers" do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @swimmers = @team.swimmers
    erb :'swimmers/index'
  end

  get "/swimmers/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'swimmers/new'
  end

  post '/swimmers' do
    redirect_if_not_logged_in
    if Swimmer.valid_params?(params)
      @team=Team.find(session[:team_id])
      @swimmer=Swimmer.create(params)
      @swimmer.team=@team
      @swimmer.save
      redirect '/swimmers'
    else
      redirect '/swimmers/new?error=invalid attributes'
    end
  end

  get '/swimmers/register_event' do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @swimmers=@team.swimmers
    @events=Event.all
    erb :'/swimmers/register_event'
    #within this view, create fields for swimmer name (auto dropdown) and show the list of events available in the form of checkboxes
    #select up to two events
  end

  post '/swimmers/register_event' do
    @swimmer=Swimmer.find_by(name: params[:swimmer][:name])
    if Team.find(session[:team_id])==@swimmer.team
      @swimmer.event_ids = params[:swimmer][:event_ids]
      @swimmer.save
      redirect :"/swimmers/register_event/#{@swimmer.slug}"
    else
      redirect '/swimmers/register_event'
    end
  end

  get '/swimmers/register_event/:slug' do
    @swimmer=Swimmer.find_by_slug(params[:slug])
    if Team.find(session[:team_id])==@swimmer.team
      erb :'/events/register_swimmer'
    else
      redirect '/swimmers/register_event'
    end
    #here for each event, put down the swimmer's timing
  end

  get "/swimmers/:slug/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @swimmer = Swimmer.find_by_slug(params[:slug])
    erb :'swimmers/edit'
  end

  get '/swimmers/:slug' do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @swimmer=Swimmer.find_by_slug(params[:slug])
    erb :'/swimmers/show'
  end


  delete '/swimmers/:swimmer_slug/:event_slug/delete' do
    @swimmer=Swimmer.find_by_slug(params[:swimmer_slug])
    @team=@swimmer.team
    @event=Event.find_by_slug(params[:event_slug])
    if @team.id=session[:team_id]
      @timing=Timing.find_by(swimmer_id: @swimmer.id, event_id: @event.id)
      @timing.delete
      redirect "/swimmers/#{@swimmer.slug}"
    else
      redirect "/swimmers/#{@swimmer.slug}"
    end
  end

  patch '/swimmers/:swimmer_slug' do
    @swimmer=Swimmer.find_by_slug(params[:swimmer_slug])
    @swimmer.update(params[:swimmer])
    @swimmer.save
    redirect "/swimmers/#{@swimmer.slug}"
  end

  patch '/swimmers/events/:swimmer_slug' do
    puts params
    @swimmer=Swimmer.find_by_slug(params[:swimmer_slug])
    @event=Event.find_by(name: params[:timing].keys[0])
    @timing=Timing.find_by(swimmer_id: @swimmer.id, event_id: @event.id)
    personal_best_update= "00:#{params[:timing]["#{@event.name}"][:personal_best]}"
    #need to add "00:" at the beginning because Time object takes in the string in the format of "00:00:00"
    #so if we provide just "00:25" then it will assume that it's 25 mins instead of 25 seconds
    @timing.update(personal_best: personal_best_update)
    @timing.save
    redirect "/swimmers/#{@swimmer.slug}"
    # this is the params hash for this patch {"timing"=>{"Boys 50m Freestyle - A Division"=>{"personal_best"=>"00:29"}}, "swimmer_slug"=>"ian-thorpe"}

  end

end

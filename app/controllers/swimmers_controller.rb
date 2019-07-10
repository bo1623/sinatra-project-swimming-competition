class SwimmersController < ApplicationController

  get "/swimmers" do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @swimmers = Swimmer.all
    erb :'swimmers/index'
  end

  get "/swimmers/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'swimmers/new'
  end

  post '/swimmers' do
    puts params
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
    @swimmer = Swimmer.find(params[:id])
    erb :'swimmers/edit'
  end

  get '/swimmers/:slug' do
    redirect_if_not_logged_in
    @team=Team.find(session[:team_id])
    @swimmer=Swimmer.find_by_slug(params[:slug])
    erb :'/swimmers/show'
  end

  post "/swimmers/:id" do
    redirect_if_not_logged_in
    @swimmer = Swimmer.find(params[:id])
    if Swimmer.valid_params?(params)
      @swimmer.update(params.select{|k|k=="name" || k=="capacity"})
      #selecting the hashes where the key is equal to either name or capacity?
      redirect "/swimmers/#{@swimmer.id}"
    else
      redirect "/swimmers/#{@swimmer.id}/edit?error=invalid attributes"
    end
  end

end

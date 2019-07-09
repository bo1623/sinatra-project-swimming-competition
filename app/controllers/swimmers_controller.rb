class SwimmersController < ApplicationController

  get "/swimmers" do
    redirect_if_not_logged_in
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
      @swimmer=Swimmer.create(params)
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

  get '/swimmers/:id' do
    redirect_if_not_logged_in
    @swimmer=Swimmer.find(params[:id])
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

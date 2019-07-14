class TeamsController < ApplicationController

  get '/teams' do
    redirect_if_not_logged_in
    @teams=Team.all
    erb :'/teams/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/teams' #if logged in then redirect the user to the index, no need for sign up
    else
      erb :'/teams/new'
    end
  end

  post '/signup' do
    if params[:teamname]=="" || params[:password]==""
      redirect '/signup'
    else
      @team=Team.create(params)
      session[:team_id]=@team.id #important so that user is logged in as soon as the team signs up
      redirect '/events'
    end
  end

  get '/login' do
    if !!session[:team_id]
      redirect '/events'
    else
      erb :'/teams/login'
    end
  end

  post '/login' do
    team=Team.find_by(teamname: params[:teamname])
    if team && team.authenticate(params[:password])
      session[:team_id]=team.id
      redirect '/events'
    else
      redirect '/signup'
    end
  end

  get '/teams/:slug' do
    redirect_if_not_logged_in
    @team=Team.find_by_slug(params[:slug])
    erb :'/teams/show'
  end

  get '/logout' do
    if session[:team_id]!=nil
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

end

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
      redirect '/teams'
    end
  end

  get '/login' do
    if !!session[:team_id]
      redirect '/teams'
    else
      erb :'/teams/login'
    end
  end

  post '/login' do
    team=Team.find_by(teamname: params[:teamname])
    if team && team.authenticate(params[:password])
      session[:team_id]=team.id
      redirect '/teams'
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


#   get '/users/:id' do
#     if !logged_in?
#       redirect '/bags'
#     end
#
#     @user = User.find(params[:id])
#     if !@user.nil? && @user == current_user
#       erb :'users/show'
#     else
#       redirect '/bags'
#     end
#   end
#
#   get '/signup' do
#     if !session[:user_id]
#       erb :'users/new'
#     else
#       redirect to '/clubs'
#     end
#   end
#
#   post '/signup' do
#     if params[:username] == "" || params[:password] == ""
#       redirect to '/signup'
#     else
#       @user = User.create(:username => params[:username], :password => params[:password])
#       session[:user_id] = @user.id
#       redirect '/bags'
#     end
#   end
#
#   get '/login' do
#     @error_message = params[:error]
#     if !session[:user_id]
#       erb :'users/login'
#     else
#       redirect '/bags'
#     end
#   end
#
#   post '/login' do
#     user = User.find_by(:username => params[:username])
#     if user && user.authenticate(params[:password])
#       session[:user_id] = user.id
#       redirect "/bags"
#     else
#       redirect to '/signup'
#     end
#   end
#

require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "swimmingisfun"
  end


  get '/' do
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
        #redirects to the login page and shows the error "you have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:team_id]
    end

    def current_user
      Team.find(session[:team_id])
    end

    def swimmer_by_slug
      @swimmer = Swimmer.find_by_slug(params[:slug])
    end

  end

end

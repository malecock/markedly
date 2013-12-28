require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'rubygems'
require 'data_mapper'

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
  end
end

get ('/markedly_styles.css'){ scss :markedly_styles}

get '/' do
	#can use protected! method to make a session login required to access this route
	@title = :home
	slim :home
end

post '/user' do
	user = User.create(params[:user])
	redirect to()
end

get '/about' do
	@title = :about
	slim :about
end

get '/user/:id' do
	protected!
	@user = params[:id]
	slim :user
end

not_found do
	#we'll create a slim 400 page
	@title = params[:not_found]
	slim :not_found
end

error do
	#for 500 status
	slim :error
end


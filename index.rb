require 'sinatra/base'

#before do
	#here I want to load content via json blob

#enable :sessions
	#here's our session, but we need a route

class Markedly < Sinatra::Base

get '/request' do
	request.methods.map { |x| x.to_s + "</br>" } 
end

get '/' do
	"Welcome"
end

get '/:name' do 
	if params[:name] && !params[:verb] then "Hello, world!  Welcome, #{params[:name]}"
	else "Hello #{params[:name]}. Welcome, #{params[:verb]}" end

	# set :views, File.dirname(__FILE__) + '/your_custom_location'
	# erb '/user/profile'.to_sy
end

get '/next' do
	"goodbye"
end

get '/:login' do
end

not_found do
	#for 400 status
end

error do
	#for 500 status
end

end


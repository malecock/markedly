require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'rubygems'
require 'data_mapper'
require './sign_up'
require './helpers.rb'
require 'securerandom'

enable :sessions

puts "This is process #{Process.pid}"
get ('/markedly_styles.css'){ scss :markedly_styles}

get '/' do
	@title = :home
	slim :home
end


post '/sign_up' do
=begin	
	session[:secret]
	if params[:url].include? "http://"
		url = params[:url]
	else
		url = params[:url].prepend("http://")
	end	

	new_record = Sign_up.create(
		:firstname => params[:firstname], 
		:lastname => params[:lastname], 
		:phone => params[:phone], 
		:email => params[:email], 
		:url => url)

	if new_record.saved? then
		#{}"firstname=#{params[:firstname]}|lastname=#{params[:lastname]}|phone=#{params[:phone]}|email=#{params[:email]}|url=#{params[:url]}"
		@record_saved = new_record.saved?
		security_check = SecureRandom.hex 
		puts @security_check
		redirect to("/confirm?val=#{security_check}")
	else
		new_record.errors.each do 
			|form_error| puts form_error 
			redirect to('/') 
		end
	end
end

get '/confirm' do
	#check = params[:security_check].to_s
		@sign_up_firstname = Sign_up.last[:firstname]
		@sign_up_lastname = Sign_up.last[:lastname]
		@sign_up_url = Sign_up.last[:url]
		@sign_up_email = Sign_up.last[:email]
		@sign_up_phone = Sign_up.last[:phone]
	slim :confirm
end
=end
not_found do
	#we'll create a slim 400 page
	@title = params[:not_found]
	slim :not_found
end

error do
	#for 500 status
	slim :error
end
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'rubygems'
require 'data_mapper'
require './sign_up'
require './helpers.rb'

puts "This is process #{Process.pid}"

get ('/markedly_styles.css'){ scss :markedly_styles}

configure :development do  
    DataMapper.auto_upgrade!  
end 

configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end

get '/' do
	@title = :home
	slim :home
end

post '/sign_up' do
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

	@record_saved = new_record.saved?
	form_errors = new_record.errors

	puts @record_saved

	form_errors.each do |form_error| 
		 puts form_error
	end

	redirect to('/')
end

get '/admin' do
	#for retrieving form submissions
	protected!
	slim :admin
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


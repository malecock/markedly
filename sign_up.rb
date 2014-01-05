require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Sign_up
	include DataMapper::Resource
	property :id, Serial
	property :firstname, String, :required => true, :messages => {:presence => "First name is a required field"}
	property :lastname, String, :required => true, :messages => {:presence => "Last name is a required field"}
	property :email, String, :required => true, :unique => true, :format => :email_address, :messages => {:presence => "Email address is a required field", :is_unique => "We already have that email address", :format => "Email addresses need to be formatted like me@me.com"}
	property :phone, String, :required => true, :messages => {:presence => "Phone is a required field"}
	property :url, String, :format => :url, :messages => {:format => "URL must be in a format like http://www.me.com"}
	property :admin, Boolean, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.finalize
#DataMapper.auto_upgrade!
#DataMapper.auto_migrate!
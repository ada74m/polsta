require 'digest/sha2'

class User < ActiveRecord::Base

	has_many :surveys

	validates_presence_of :email, :on => :create
	validates_uniqueness_of :email, :on => :create
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create, :allow_blank => true
	
	validates_presence_of :account_name, :on => :create
	validates_uniqueness_of :account_name, :on => :create, :allow_blank => true
	validates_length_of :account_name, :within=>3..20, :on => :create, :allow_blank => true
	validates_format_of :account_name, :with => /^[a-z0-9]+$/, :on => :create, :message => "can only contain numbers and lower-case letters", :allow_blank => true

	#validates_presence_of :password_hash, :message => "can't be blank"

	def initialize(email, account_name, password)
		super()
		self.email = email
		self.account_name = account_name
		@password = password
	end
	
	def self.authenticate(email, password)
		user = User.find_by_email email
		if (user) 
			salt = user.password_salt
			hash = Digest::SHA256.hexdigest(password + salt)
			stored_hash = user.password_hash
			return user if hash == stored_hash
		end
		nil
	end

	protected
	
	def validate
		if @password.blank?
			errors.add "password", "can't be blank" unless password_hash
		else
			errors.add "password", "is too long (maximum is 16 characters)" if @password.length > 16
			errors.add "password", "is too short (minimum is 6 characters)" if @password.length < 6
		end
	end

	def before_create
		hash_password
	end

	def before_save
		hash_password
	end
	
	private
	
	def hash_password
		if @password
			salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
			hash = Digest::SHA256.hexdigest(@password + salt)
			self.password_salt = salt
			self.password_hash = hash
		end
	end

end

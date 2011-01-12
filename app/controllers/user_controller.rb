class UserController < ApplicationController

	def signin
		if session[:intended_action] == "save"
			@msg = "You need to sign in or register before you can save your survey.<br/>"
		end

		if request.post?
			user = User.authenticate(params[:email], params[:password])
			if user
				session[:user] = user.id
				session[:has_accepted_terms] = user.has_accepted_terms
				carry_on
			else
				flash[:login_error] = "Email address or password invalid"
			end
		end

		@breadcrumbs = [["home", home_url], ["login", nil]]
	end

	def terms
		if request.post?
			
			if params[:agree] 
				user = get_user
				if user
					user.has_accepted_terms = 1
					session[:has_accepted_terms] = 1
					user.save!
					carry_on
					return
				end
			end
			
			signout
		end
	end

	def register
		
		if params[:password] == params[:retype_password]
			user = User.new(params[:email], params[:account_name], params[:password])

			if user.save
				session[:user] = user.id
				carry_on
				return
			else
				errors = user.errors.each_full{ |m| m }.join "<br/>"
			end
		else
			errors = "passwords do not match<br/>"
		end
			
		flash[:registration_error] = errors
		render :template => "user/signin"
		
	end
		
	def signout
		reset_session
		redirect_to home_url
	end

	private
	
	def carry_on

		intended_params = session[:intended_params]

		if intended_params
			redirect_to intended_params
		else
			redirect_to home_url
		end

		session[:intended_params] = nil

	end
	
	

end

class CreditsController < ApplicationController


	def buy
	end

	def fake_buy
		user = get_user
		number = params[:number_to_buy].to_i
		user.credits += number
		if (user.credits > 500) 
			user.credits = 500
			flash[:alert] = "You have 500 credits, which is the maxumum allowed during the alpha/beta period";
		end
		user.save
		carry_on
	end

	def carry_on

		return_uri = session[:return_uri]


		if return_uri
			redirect_to return_uri
			session[:return_uri] = nil
		else
			redirect_to home_url
		end
	end

end

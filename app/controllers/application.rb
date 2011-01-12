# Load non-active-record models
Address
AddressQuestion
Command
DateQuestion
DeleteElementCommand
DemoteElementCommand
Design
DoNothingCommand
Element
EmailQuestion
EndOfSurvey
InsertElementCommand
ListQuestion
MatrixQuestion
NumberQuestion
PageBreak
Paragraph
Picture
PromoteElementCommand
Question
SurveyHeader
TextQuestion
UrlQuestion
ValueSetterCommand


# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => 'c55aa8d88d0de2198d2cdf3ace52a102'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password


	# load every single model... there *must* be a better way
#	model :command, :delete_element_command, :demote_element_command, :design, :do_nothing_command, :element, :insert_element_command, :list_question, :matrix_question, :page_break, :promote_element_command, :question, :response, :survey, :text_question, :user, :value_setter_command, :version, :survey_header, :end_of_survey, :paragraph, :date_question, :address
	

	before_filter :load_user


	def load_user
		@user = get_user
	end

	def check_authentication

		unless session[:user]
			session[:intended_params] = params
			redirect_to :controller => "user", :action => "signin"
			return false
		end
		
		unless session[:has_accepted_terms] == 1
			session[:intended_params] = params
			redirect_to :controller => "user", :action => "terms"
			return false
		end 
		
		true
	end
	
	

	def get_user
		nil unless session[:user]
		
		if !@cached_user || @cached_user.id != session[:user]
			@cached_user = User.find_by_id session[:user]
		end
		
		@cached_user
	end

	

end

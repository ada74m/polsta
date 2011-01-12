class AdminController < ApplicationController

	before_filter :check_authentication, :except => [:start_with_blank_design, :index, :save]

	def index
		if params[:embed]
			survey = Survey.find_by_embedding_id params[:embed]
			#render :text => url_for(:controller => 'public', :action=> 'embed_survey', :account_name => survey.user.account_name, :survey_url_name => survey.url_name)
			redirect_to :controller => 'public', :action=> 'embed_survey', :account_name => survey.user.account_name, :survey_url_name => survey.url_name
			return;
		end

		redirect_to :action => :list if get_user
	end

	def list

		surveys = Survey.find_all_by_user_id get_user.id
		
		@account_name = get_user.account_name

		@rows = []

		for survey in surveys
			row = { :name => survey.name, 
				:url_name => survey.url_name, 
				:status => survey.status,
				:responses => survey.responses_count
			}


			
			@rows << row
		end

		@breadcrumbs = [["my surveys",nil]]
		
	end


	def detail 
		@survey = find_survey

		@design = nil
		@live = nil
		@archived = []
		
		for version in @survey.versions
			@design = version if version.state == 1
			@live = version if version.state == 2
			@archived << version if version.state == 3
		end

		@rss = formatted_response_url(@survey.rss_id, :rss)

		@breadcrumbs = [["my surveys", url_for(:action=>"list")], [@survey.url_name,nil]]
		
	end
	
	def publish
		version_to_publish = find_survey.version_in_design
		version_to_publish.publish!
		redirect_to :action => :detail, :url_name => version_to_publish.survey.url_name
	end

	def archive
		version_to_archive = find_survey.live_version
		version_to_archive.archive!
		redirect_to :action => :detail, :url_name => version_to_archive.survey.url_name
	end

	def edit
		survey = find_survey
		if survey 
			version = survey.version_in_design
			session[:design] = version.design
			session[:version] = version.id
			session[:survey_name] = version.survey.name
			session[:survey_url_name] = version.survey.url_name
			redirect_to :controller=>'design'
		end

	end

	def start_with_blank_design
		session[:design] = Design.new
		session[:version] = nil
		session[:survey_name] = "new survey"
		redirect_to :controller=>'design'
	end

	def save
		if params["commit"] == "Save"
			return unless check_authentication
			if !session[:version]
				if request.post? && params[:name]
					# name for survey supplied
					# create survey
					new_survey = Survey.new
					new_survey.name = params[:name]
					new_survey.user = get_user
					# create first version
					first_version = Version.new
					new_survey.versions << first_version
					# save the whole lot
					if new_survey.save
						session[:version] = first_version.id
					else
						errors = "<div class=\"error\">Failed to save survey for these reasons:<ul>\n"
						new_survey.errors.each_full { |msg| errors << "<li>" << msg << "</li>" }
						errors << "</div>"
						flash[:notice] = errors
						@breadcrumbs = [["Save survey",nil]]
						render :template => "admin/set_name"
						return
					end
				else
					# ask user for name of survey
					@breadcrumbs = [["Save survey",nil]]
					render :template => "admin/set_name"
					return
				end
			end
			
			# by this point the version id must be available
			version_id = session[:version]
			version_to_save = Version.find_by_id(version_id)
			version_to_save.design = session[:design]
			version_to_save.save
			redirect_to url_for(:controller => 'admin', :action => 'detail', :url_name => version_to_save.survey.url_name)
		else #cancel
			if session[:version]
				version = Version.find_by_id(session[:version])
				redirect_to url_for(:controller => 'admin', :action => 'detail', :url_name => version.survey.url_name)
			else
				redirect_to url_for(:controller => 'admin')
			end
		end
	end

	def responses 
		@version = find_version
		@name = @version.survey.name
		@position = @version.position
		@responses_count = @version.responses_count
		@page_size = 20
		@pages = @responses_count / @page_size
		@pages += 1 if (@responses_count % @page_size) > 0
		if params[:page]
			@page = (params[:page]).to_i - 1
		else
			@page = 0
		end
		@first = @page_size * @page + 1
		@last = @first + @page_size - 1
		@last = @responses_count if @last > @responses_count
		responses = Response.find_all_by_version_id(@version.id, :order=>"created_at", :limit=>@page_size, :offset=>@first-1)

		design = @version.design
		@cols = ["When", "IP addr"] + design.response_column_headers
		
		
		@rows = []
		for r in responses
			row = [r.created_at.to_s(:long), r.remote_ip]
			for q in design.questions
				cell = q.response_columns(r.answers)
				row << cell
			end
			@rows << row 
		end

		@breadcrumbs = [["my surveys", url_for(:action=>"list")], [@version.survey.url_name, url_for(:action=>"detail", :url_name=>@version.survey.url_name, :version=>nil)], ["version #{@version.position} responses", nil]]

	end
	
	def responses_csv 

		require 'csv'
		
		@version = find_version
		@name = @version.survey.name
		@position = @version.position
		@responses_count = @version.responses_count
		design = @version.design
		@cols = ["When", "IP addr"] + design.response_column_headers
				
		content_type = if request.user_agent =~ /windows/i
			"application/vnd.ms-excel"
		else
			"text/csv"
		end
		
		output = ""

		CSV::Writer.generate(output) do |csv|

			csv << (["When", "IP addr"] + design.response_column_headers)

			responses = Response.find(:all, :conditions=>["version_id=?", @version.id], :order=>"created_at")
			responses.each do |response|
				
				row = [response.created_at.to_s(:long), response.remote_ip]
				
				for q in design.questions
					row += q.response_columns(response.answers) 
				end
				
				csv << row

			end
		end

		filename = "#{@version.survey.url_name}.v#{@position}.responses.csv"

		send_data(output, :type=>content_type, :filename => filename)

	end
	
	

	def unlock 

		load_vars

		@breadcrumbs = [
			["my surveys", url_for(:action=>"list")], 
			[@version.survey.url_name, url_for(:action=>"detail", :url_name=>@version.survey.url_name, :version=>nil)], 
			["version #{@version.position} responses", url_for(:action => 'responses', :url_name => @version.survey.url_name, :version => @version.position)],
			["unlock", nil]
		]

		session[:return_uri] =  request.request_uri


		if request.post?
			#render :text=>params
			credits_to_use = params[:credits_to_use].to_i
			credits_to_use = @max if credits_to_use > @max
			
			
			@version.pay!(credits_to_use)

			
			flash[:alert] = "You have used #{credits_to_use} credits to unlock responses to #{@name} version #{@position}"


			redirect_to :controller=>"admin", :action=>"responses", :version=>@position, :url_name=>@version.survey.url_name
			

		end

	end


	def buy_credits
	
		redirect_to :controller=>"credits", :action=>"buy";
	
	end


	private 

	def find_survey 
		url_name = params[:url_name]
		account_name = get_user.account_name
		survey = Survey.find_by_url_name_and_user_id url_name, get_user.id
		return nil if survey.user.account_name != account_name
		return survey
	end
	
	def find_version
		url_name = params[:url_name]
		position = params[:version]
		account_name = get_user.account_name
		survey = Survey.find_by_url_name url_name
		version = Version.find :first, :conditions => ["survey_id = ? and position = ?", survey.id, position]
		return version
	end

	def load_vars
		@version = find_version
		@name = @version.survey.name
		@position = @version.position
		@user = get_user


	
	end


end

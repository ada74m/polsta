class PublicController < ApplicationController

	before_filter :check_authentication, :only => [:preview_survey]

	def show_survey
		present "layouts/public"
	end

	def embed_survey
		present "layouts/embedded"
	end

	def preview_survey
		url_name = params[:survey_url_name]
	
		user_id = get_user.id
	
		in_design = Version.find(:first, 
			:conditions => ["surveys.user_id = ? and surveys.url_name like ? and versions.state=1", user_id, url_name],
			:include => [:survey]
		)

		if in_design.blank?
			render :template => "public/no_such_survey"
			return
		end
		
		@id = in_design.id
		@survey_name = in_design.survey.name
		@design = in_design.design

	end
	

	def thankyou
		present_thankyou "layouts/public"
	end
	

	def embedded_thankyou
		present_thankyou "layouts/embedded"
	end
	

	private

	def present_thankyou(layout)
		live = get_live_version;
		
		if live.blank?
			render :template => "public/no_such_survey"
			return
		end
		
		design = live.design
		
		questions = design.response_column_headers
		answers = []
		response = Response.find_by_guid(params[:guid])
		if response
			for q in design.questions
				answers << q.response_columns(response.answers) 
			end
		end
		
		@google = (0...questions.size).map { |i| [questions[i], answers[i]] }
		
		@end_of_survey = design.end_of_survey
		
		render :layout=>layout
		
	end

	def present (layout) 
		live = get_live_version;

		if live.blank?
			render :template => "public/no_such_survey"
			return
		end
		
		@id = live.id
		@survey_name = live.survey.name
		design = live.design

		@validation_errors = {}

		if request.post?

			# get answers hash out of session
			@answers = session[:answers]

			# get page number from hidden field
			@page = session[:page]

			if params["submit"] == "back" 
				# don't gather; don't validate; just go back a page
				@page -= 1
			else
				# get questions on this page
				questions = design.get_page_of_questions(@page)

				# gather values from form and check validity
				for question in questions
					answer = question.construct_answer_from_form_parameters(params)
					@answers[question.id] = answer
					question.public_validation_problems(answer).each do |error| 
						@validation_errors[question.id] ||= []
						@validation_errors[question.id] << error 
					end
				end

				# save answers in session
				session[:answers] = @answers
				
				# re-present if necessary
				if @validation_errors.size > 0
				else
					# no validation errors on page just done
					# save response and go to thank-you if this was the last page

					if @page + 1 == design.number_of_pages
						resp = Response.for_version(live, request.remote_ip)
						resp.answers = @answers
						session[:answers] = nil
						resp.save!
						if layout.include?("embedded")
							redirect_to :action => :embedded_thankyou, :guid => resp.guid
						else
							redirect_to :action => :thankyou, :guid => resp.guid 
						end
						return
						
					end
					# otherwise go to the next page
					@page += 1
				end
			end

		else
			# initialize answers hash
			session[:answers] = @answers = {}
			# show the first page			
			@page = 0
			
		end

		session[:page] = @page
		@first_page = (@page == 0)
		@last_page = (@page+1 == design.number_of_pages)
		design.take_value_from_answers(@answers)
		@header = design.header
		@show_header = (@first_page || !@header.first_page_only)
		@end_of_survey = design.end_of_survey
		@elements = design.get_page_of_contents(@page)
	
		render :layout => layout, :template=>"public/show_survey"
	

	end



	def get_live_version
	
		account_name = params[:account_name]
		url_name = params[:survey_url_name]

		account = User.find_by_account_name(account_name)
		owner_user_id = account.id
		
		return Version.find(:first, 
			:conditions => ["surveys.user_id = ? and surveys.url_name like ? and versions.state=2", owner_user_id, url_name],
			:include => [:survey]
		)
		
	
	end


end

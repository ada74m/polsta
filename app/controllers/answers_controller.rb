class AnswersController < ApplicationController
  layout 'layouts/public'
	
  def show
  	@response = Response.find(:first, :include=>{:version => :survey }, :conditions=>{:guid=>params[:id]})

  	@breadcrumbs = [["#{@response.created_at.to_formatted_s(:long_ordinal)} for version #{@response.version.position} of survey \"#{@response.version.survey.name}\"",nil]]

	design = @response.version.design
	
	questions = design.response_column_headers
	answers = []

	for q in design.questions
		answers += q.response_columns(@response.answers) 
	end
	
	@answers = (0...questions.size).map { |i| [questions[i], answers[i]] }

  end

end

class ResponseController < ApplicationController
  layout 'layouts/public'
	
  def show
  	@response = Response.find(:first, :include=>{:version => :survey }, :conditions=>{:guid=>params[:id]})

  	@breadcrumbs = [["#{@response.created_at.to_formatted_s(:long_ordinal)} for version #{@response.version.position} of survey \"#{@response.version.survey.name}\"",nil]]
  end

end

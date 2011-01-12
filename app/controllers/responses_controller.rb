class ResponsesController < ApplicationController
  def show
  	rss_id = params[:id]
  	#@responses = Response.find(:all, :joins=>[{:version => :survey}], :conditions=>{'surveys.rss_id'=>rss_id}, :order=>"id desc" )
  	@survey = Survey.find_by_rss_id(rss_id)
  	@responses = Response.find(:all, :include=>:version, :conditions=>{'versions.survey_id'=>@survey.id})




  end
end

module AdminHelper

	def responses_link version
		count = version.responses_count
		word = "response"
		word = word.pluralize if count != 1
		link_to "#{count} #{word}", :action => 'responses', :url_name => version.survey.url_name, :version => version.position
	end

	def response_pagination_links
		pagination_links @response_pages, :link_to_current_page=>true, :params=>{ :url_name => @version.survey.url_name, :version => @version.position }	
	end

	def embedding_code(id, name)
		"<a href=\"#{home_url}?embed=#{id}\" id=\"polstalink#{id}\">#{name}</a><script type=\"text/javascript\" src=\"#{home_url}javascripts/embedding.js\" ></script><script type=\"text/javascript\">polstaEmbed('#{id}', '#{home_url}')</script>"
	end



end

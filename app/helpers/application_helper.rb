# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def format_text(text)
		text.gsub "\n", "<br/>"
	end


	def breadcrumbs
		out = "";
		
		if @breadcrumbs

			@breadcrumbs.each do |pair| 
				out += " : " if out != "" 
				if (pair[1])
					out += link_to pair[0], pair[1]
				else
					out += pair[0]
				end
			end

		end
		#return "<div id=\"breadcrumbs\">#{out}</div>"
		return out

	end



end

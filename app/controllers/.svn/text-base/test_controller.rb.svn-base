class TestController < ApplicationController

	def get
	
	
	end
	
	
	def reorder 
		render :update do |page| 
			page.remove "three"
			page.insert_html :after, "one", "<div id='three'>THREE</div>"
		end
	end

end

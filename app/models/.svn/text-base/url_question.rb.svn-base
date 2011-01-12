class UrlQuestion < Question

	def to_s 
		"Website address question"
	end

	def public_validation_problems(answer)
		problems = super
		
		if (answer == "")
			problems << "Please fill in this question." if @mandatory
		else
			problems << "Not a valid website address" if !(answer =~ /^([a-zA-Z0-9-]+\.)+([a-zA-Z0-9-]+)(:[0-9]+)?(\/([a-zA-Z0-9\-_\.]*))*?(\?([^&#\?]+(=[^&#\?]*)?)?(&[^&#\?]+(=[^&#\?]*)?)*)?(#[^&#\?]*)?$/)
		end
		problems
	end

end
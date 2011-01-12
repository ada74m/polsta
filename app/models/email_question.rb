class EmailQuestion < Question

	def to_s 
		"Email address question"
	end


	def public_validation_problems(answer)
		problems = super
		
		if (answer == "")
			problems << "Please fill in this question." if @mandatory
		else
			problems << "Not a valid email address" if !(answer =~ /^([a-zA-Z0-9_\-\+']+(\.[a-zA-Z0-9_\-']+)*@([a-zA-Z0-9_\-\+']+\.)+[a-zA-Z]+)?$/)
		end
		problems
	end

end
require 'date'

class DateQuestion < Question

	attr_accessor :format

	def initialize
		super
	end

	def to_s 
		"Date question"
	end


	def public_validation_problems(answer)
		problems = super
		
		if (answer == "")
			problems << "Please fill in this question." if @mandatory
		else
			Date::parse(answer, true) rescue problems << "Date is invalid" 
		end
		problems
	end
	
	def construct_answer_from_form_parameters(params) 

		params["#{id}.value"]
			
	end
	
	def response_columns(answers) 
		
		answer = answers[id]

		return [(Date::parse(answer, true)).to_s] rescue nil
		
	end

end
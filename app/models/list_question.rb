class ListQuestion < Question

	attr_accessor :responses
	attr_accessor :style # radios|checkboxes
	attr_accessor :show_other
	attr_accessor :show_none

	def initialize
		super
		@responses = ""
		@style = "radios"
		@show_other = false
		@show_none = false
	end
	
	def responses_array
		@responses.split("\n").map { |s| s.chomp } 
	end

	def to_s 
		"List question"
	end

	def validation_problems
		problems = super
		problems << "list must contain at least one item" if responses_array.length == 0
		problems;
	end

	def reset_prior_to_gathering_form_data
		super
		@show_other = false
		@show_none = false
	end
	
	def list_value
		if @value
			@value[:list]
		else
			nil
		end
	end
	
	def other_value
		if @value
			@value[:other]
		else
			nil
		end
	end
	
	def item_selected item
		if list_value
			list_value.include? item
		else
			false
		end
	end

	def construct_answer_from_form_parameters(params) 
		{ :list => params[id] || [], :other => params[id + ":other"] }
	end

	def public_validation_problems(answer)
		problems = super
		problems << "Please fill in this question." if answer[:list].length == 0 && @mandatory
		return problems
	end

	def response_columns(answers) 
		if @style == "radios" 
			[(answers[id])[:list]]
		else
			[(answers[id])[:list].join("|")]
		end
	end

end
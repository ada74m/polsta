class MatrixQuestion < Question

	attr_accessor :question_parts
	attr_accessor :responses
	attr_accessor :style # radios|checkboxes
	attr_accessor :show_other
	attr_accessor :show_none

	def initialize
		super
		@question_parts = ""
		@responses = ""
		@style = "radios"
		@show_other = false
		@show_none = false
	end
	
	def responses_array
		@responses.split("\n").map { |s| s.chomp } 
	end

	def question_parts_array
		@question_parts.split("\n").map { |s| s.chomp } 
	end

	def to_s 
		"Matrix question"
	end

	def validation_problems
		problems = super
		problems << "responses parts must contain at least one item" if responses_array.length == 0
		problems << "questions must contain at least one item" if question_parts_array.length == 0
		problems;
	end

	def reset_prior_to_gathering_form_data
		super
		@show_other = false
		@show_none = false
	end

	def construct_answer_from_form_parameters(params) 		
		answer_parts = []
		
		i = 0
		for part in question_parts_array
			answer_parts << {:list => params["#{id}:#{i}"] || [], :other => params["#{id}:#{i}:other"] }
			i += 1
		end
		
		answer_parts
		
	end

	def list_value(i)
		if @value
			@value[i][:list]
		else
			nil
		end
	end
	
	def other_value(i)
		if @value
			@value[i][:other]
		else
			nil
		end
	end
	
	def item_selected(i, item)
		if list_value(i)
			list_value(i).include? item
		else
			false
		end
	end

	def public_validation_problems(answer)
		problems = super
		missing = false
		i = 0
		for part in question_parts_array
			missing ||= (answer[i][:list].length == 0 && @mandatory)
			i += 1
		end
		problems << "Please fill in every row of the matrix." if missing

		problems
	end

	def response_column_headers
		question_parts_array
	end

	def response_columns(answers) 
		if @style == "radios" 
			answers[id].map { |a| a[:list] }
		else
			answers[id].map { |a| a[:list].join("|") }
		end
	end

end
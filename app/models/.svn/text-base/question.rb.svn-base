class Question < Element

	attr_accessor :text
	attr_accessor :extra_text
	attr_accessor :mandatory
	attr_accessor :value

	def initialize
		super
		@text = "" unless @text
		@extra_text = "" unless @extra_text
		@mandatory = false unless @mandatory
	end

	def validation_problems
		problems = super
		problems << "text cannot be empty" if @text == ""
		problems;
	end

	def take_value_from_answers(answers)
		@value = answers[id]
	end

	def construct_answer_from_form_parameters(params) 
		params[id]
	end
	
	def public_validation_problems(answer) 
		[]
	end

	def response_column_headers
		[@text]
	end

	def response_columns(answers) 
		
		answer = answers[id]
		#if answer.instance_of? YAML::Object
		#	answer = YAML::load(answer)
		#end

		
		return [answer]
	end

end
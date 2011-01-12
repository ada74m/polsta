class TextQuestion < Question

	attr_accessor :response_text
	attr_accessor :rows

	def initialize
		super
		@rows = 1
	end

	def to_s 
		"Text question"
	end

	def validation_problems
		problems = super
		problems << "rows must be greater than zero" if @rows == 0
		problems << "rows must be 20 at most" if @rows > 20
		problems;
	end

	def public_validation_problems(answer)
		problems = super
		problems << "Please fill in this question." if answer=="" && @mandatory
		problems
	end


end
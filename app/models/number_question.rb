class NumberQuestion < Question

	attr_accessor :decimal
	attr_accessor :minimum
	attr_accessor :maximum

	def initialize
		super
		@decimal = false unless @decimal
	end

	def to_s 
		"Number question"
	end


	def public_validation_problems(answer)
		problems = super
		
		if (answer == "")
			problems << "Please fill in this question." if @mandatory
		else
			if @decimal
				problems << "Not a valid decimal number" if !(answer =~ /^[0-9]*(\.[0-9]+)?$/)
			else
				problems << "Not a valid integer number" if !(answer =~ /^[0-9]*$/)
			end
		end
		problems
	end

end
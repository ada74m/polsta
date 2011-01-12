class AddressQuestion < Question

	attr_accessor :line1label
	attr_accessor :line1usage 

	attr_accessor :line2label
	attr_accessor :line2usage 

	attr_accessor :line3label
	attr_accessor :line3usage 

	attr_accessor :line4label
	attr_accessor :line4usage 

	attr_accessor :line5label
	attr_accessor :line5usage 


	def initialize
		super
		@line1label = "address line 1"
		@line1usage = "essential"
		@line2label = "address line 2"
		@line2usage = "optional"
		@line3label = "address line 3"
		@line3usage = "optional"
		@line4label = "country"
		@line4usage = "optional"
		@line5label = "zip/postcode"
		@line5usage = "optional"
	end

	def to_s 
		"Address question"
	end

	def public_validation_problems(answer)
		problems = super
		problems << "Please fill in this question." if answer.empty? && @mandatory
		puts "XXXXXXXXX #{answer.empty?}"
		if !answer.empty?
			problems << "Line 1 required" if (answer.line1 == "" && line1usage == "essential") 
			problems << "Line 2 required" if (answer.line2 == "" && line2usage == "essential") 
			problems << "Line 3 required" if (answer.line3 == "" && line3usage == "essential") 
			problems << "Line 4 required" if (answer.line4 == "" && line4usage == "essential") 
			problems << "Line 5 required" if (answer.line5 == "" && line5usage == "essential") 
		end
		problems
	end
	
	def construct_answer_from_form_parameters(params) 

		line1 = params["#{id}:line1"]
		line2 = params["#{id}:line2"]
		line3 = params["#{id}:line3"]
		line4 = params["#{id}:line4"]
		line5 = params["#{id}:line5"]

		a = Address.new(line1, line2, line3, line4, line5)

		return a
			
	end


	def line1 
		return nil unless @value
		@value.line1
	end

	def line2 
		return nil unless @value
		@value.line2
	end

	def line3 
		return nil unless @value
		@value.line3
	end

	def line4 
		return nil unless @value
		@value.line4
	end

	def line5 
		return nil unless @value
		@value.line5
	end

end
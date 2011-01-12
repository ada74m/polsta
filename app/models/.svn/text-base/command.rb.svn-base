class Command

	attr_accessor :design
	attr_accessor :target_id
	attr_accessor :done

	def initialize(design, target_id)
		@design = design
		@target_id = target_id
	end

	def find_target
		@design.find_element(@target_id)
	end

	def do 
		@done = true
	end

	def undo
		@done = false
	end

end



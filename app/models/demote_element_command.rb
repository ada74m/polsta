class DemoteElementCommand < Command

	attr_accessor :element_id

	def initialize(design, target_id, element_id)
		super(design, target_id)
		@element_id = element_id
	end

	def do 
		@design.demote_element(@element_id)
		super
	end
	
	def undo 
		@design.promote_element(@element_id)
		super
	end


end
class DeleteElementCommand < Command 

	attr_accessor :element_id

	def initialize(design, target_id, element_id)
		super(design, target_id)
		@element_id = element_id
	end

	def do 
		@deleted_element = @design.delete_element(@element_id)
		super
	end
	
	def undo 
		@design.reinstate_element(@deleted_element)
		super
	end

end
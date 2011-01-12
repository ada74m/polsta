class InsertElementCommand < Command 

	attr_accessor :element_type
	attr_accessor :before_element_id

	def initialize(design, target_id, element_type, before_element_id)
		@element_type = element_type
		@before_element_id = before_element_id
		super(design, target_id)
	end

	def do 
		@inserted_id = @design.insert_element(@element_type, @before_element_id).id;
		super
	end

	def undo
		@design.delete_element(@inserted_id);
		super
	end

end
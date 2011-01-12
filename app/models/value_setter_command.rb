class ValueSetterCommand < Command 

	attr_accessor :property
	attr_accessor :old_value
	attr_accessor :new_value

	def initialize(design, target_id, property, old_value, new_value)
		super(design, target_id)
		@property = property
		@old_value = old_value
		@new_value = new_value
	end

	def do
		target = find_target
		setter = target.method("#{@property}=");
		setter.call(@new_value);
		super
	end
	
	def undo
		target = find_target
		setter = target.method("#{@property}=");
		setter.call(@old_value);
		super
	end

end
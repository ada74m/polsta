require "digest/md5"

class Element

	attr_accessor :id
	attr_accessor :position
	attr_accessor :design

	def initialize
		@id = newId
	end

	def newId
		Digest::MD5.hexdigest("#{Time.new.to_i} #{Time.new.usec} #{Kernel.rand}")
	end

	def to_s
		"element #{@id}"
	end

	def display_template_name
		"public/" + Inflector.underscore(self.class.to_s)
	end
	
	def edit_template_name
		Inflector.underscore(self.class.to_s) + "_editor"
	end
	
	def one_before
		@design.elements[@position-1]
	end
	
	def one_after
		@design.elements[@position+1]
	end
	
	def valid
		validation_problems.length == 0
	end
	
	def validation_problems
		[]
	end

	def set_property(property, new_value) 
		getter = method(property)
		old_value = getter.call
		new_value = convert_to_same_type(new_value, old_value)
		if (old_value != new_value)
			command = ValueSetterCommand.new(@design, @id, property, old_value, new_value)
			command.do
			@design.commands << command
		end
	end

	def reset_prior_to_gathering_form_data
	end
	
	def editable?
		true
	end
	
	def promotable?
		@position > 0
	end
	
	def demotable?
		@position < @design.elements.length-1
	end
	
	def deletable?
		true
	end

	private
	def convert_to_same_type(changeme, leaveme) 

		changeme = changeme[0] if changeme.is_a? Array

		if leaveme.is_a? String
			return changeme.to_s
		elsif leaveme.is_a? Integer
			return changeme.to_i
		elsif (leaveme.is_a?(TrueClass) | leaveme.is_a?(FalseClass))
			return false if (changeme.to_s == "false")
			return false if (changeme.to_s == "")
			return true
		end

		return changeme

	end

	

	
end
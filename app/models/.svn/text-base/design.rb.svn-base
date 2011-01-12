class Design

	attr_accessor :elements
	attr_accessor :commands
	attr_accessor :rollback_points
	attr_accessor :name
	attr_accessor :last_element_added
	attr_accessor :header
	attr_accessor :end_of_survey
	

		
	def initialize
		@elements = []
		@commands = []
		@rollback_points = []
		@last_element_added = nil

		@header = SurveyHeader.new
		@header.design = self
		@header.first_page_only = false
		@header.heading = "New survey"

		@end_of_survey = EndOfSurvey.new
		@end_of_survey.design = self

		intro = insert_element "Paragraph", nil
		intro.heading = "Start by deleting this element..."
		intro.text = "...and then click \"insert element\" to add a question, text or graphics to the survey."


	end

	def insert_element(element_type, before_element_id)
		before = find_element(before_element_id)
		el = eval("#{element_type}.new")
		el.design = self
		if before 
			el.position = before.position - 0.5
		else
			el.position = @elements.length 
		end
		@elements << el
		sort_elements
		@last_element_added = el
		return el
	end

	def delete_element(element_id) 
		deleted = find_element(element_id)
		if deleted 
			@elements.delete(deleted)
			sort_elements
			deleted
		end
	end
	
	def promote_element(element_id)
		element = find_element(element_id)
		if element
			element.position -= 1.5
			sort_elements
		end
	end
	
	def demote_element(element_id)
		element = find_element(element_id)
		if element
			element.position += 1.5
			sort_elements
		end
	
	end

	def execute(command_text) 
		# command_text is [target_id] [command_subclass] [parameters]
		# target_id and parameters are optional
		
		if command_text =~ /^(([0-9a-f]{32}) )?([^ ]+)( (.*))?$/
			target_id = Regexp.last_match(2)
			command_subclass = Regexp.last_match(3)
			parameters = Regexp.last_match(5)
			ruby = "#{command_subclass}Command.new(self, target_id#{", #{parameters}" if parameters})"
			command = eval(ruby)
			command.do
			@commands << command
		end
	
	end


	def rollback
		rollback_point = rollback_points.pop
		while command_number > rollback_point
			undo_last_command
		end
	end


	def command_number
		@commands.length
	end

	def set_rollback_point
		@rollback_points << command_number
	end


	def find_element(id)
		
		return @header if id == @header.id
		return @end_of_survey if id == @end_of_survey.id
		
		@elements.each { |el|
			return el if el.id == id
		}
		nil
	end
	

	def reinstate_element(element) 
		@elements << element
		element.position -= 0.5
		sort_elements
	end

	def number_of_pages
		count = 1
		elements.each do |element|
			count += 1 if element.kind_of? PageBreak
		end
		return count
	end
	
	def get_page_of_contents(desired_page)
		current_page = 0
		contents = []
		@elements.each do |element|
			if element.kind_of? PageBreak
				break if current_page == desired_page
				current_page += 1
			else
				contents << element if current_page == desired_page
			end
		end
		contents;
	end

	def get_page_of_questions(desired_page)
		questions = []
		contents = get_page_of_contents(desired_page)
		contents.each do |element|	
			questions << element if element.kind_of? Question
		end
		questions
	end

	def take_value_from_answers(answers)
		for question in questions
			question.take_value_from_answers(answers)
		end
	end

	def response_column_headers
		cols = []
		for element in questions
			cols += element.response_column_headers
		end

		return cols

	end

	def questions 
		questions = []
		for element in @elements
			questions << element if element.kind_of? Question
		end
		questions
	end
	
	private
	def sort_elements
		@elements.sort! { |x,y| x.position <=> y.position }
		i = 0;
		@elements.each { |el| el.position = i; i += 1 }
	end

	def undo_last_command
		# undo the last command
		@commands.last.undo
		@commands.delete @commands.last
	end

end
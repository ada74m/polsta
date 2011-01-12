require File.dirname(__FILE__) + '/../test_helper'

class DesignTest < Test::Unit::TestCase

	def setup
		@design = Design.new	
		@design.elements.clear
	end

	def test_design_created
		assert_kind_of Design, @design
	end

	def test_design_has_elements_and_commands
		assert_kind_of Array, @design.elements
		assert_kind_of Array, @design.commands
	end
	
	
	def test_insert_elements_at_end

		@design.execute "InsertElement 'TextQuestion', nil"

		assert_kind_of(InsertElementCommand, @design.commands[0])
		assert_equal(@design, @design.commands[0].design)
		assert(@design.commands[0].done)
		assert_equal(1, @design.elements.length)
		assert_kind_of(Question, @design.elements[0])
		assert_not_nil(@design.elements[0].id)

		assert_equal(0, @design.elements[0].position)

		@design.execute "InsertElement 'Question', nil"
		assert_equal(1, @design.elements[1].position)
	end
	
	def test_insert_elements_at_start
		@design.execute "InsertElement 'TextQuestion', nil"
		elA = @design.elements[0]
		@design.execute "InsertElement 'TextQuestion', '#{elA.id}'"
		elB = @design.elements[0]
		
		assert_not_same(elA, elB)
		assert_equal(0, elB.position)
		assert_equal(1, elA.position)
	end
	
	
	def test_undo_insert_at_end

		@design.execute "InsertElement 'TextQuestion', nil"
		@design.set_rollback_point
		@design.execute "InsertElement 'TextQuestion', nil"

		assert_equal(2, @design.elements.length)
		assert_equal(2, @design.commands.length)
		
		elA = @design.elements[0]
		
		@design.rollback
		
		assert_equal(1, @design.elements.length)
		assert_same(elA, @design.elements[0])
		
	end

	def test_undo_insert_at_start
		@design.execute "InsertElement 'TextQuestion', nil"
		assert_equal(1, @design.elements.length)
		assert_equal(1, @design.commands.length)
		
		command = @design.commands[0]
		assert(command.done)
		command.undo
		assert(!command.done)
		
	end
	
	def test_find_by_id

		@design.execute "InsertElement 'TextQuestion', nil"
		@design.execute "InsertElement 'TextQuestion', nil"
		@design.execute "InsertElement 'TextQuestion', nil"

		assert_equal(3, @design.elements.length)

		elA = @design.elements[0]
		elB = @design.elements[1]
		elC = @design.elements[2]

		assert_same(elA, @design.find_element(elA.id));
		assert_same(elB, @design.find_element(elB.id));
		assert_same(elC, @design.find_element(elC.id));
		
	end
	
	def test_insert_elements_in_middle
		@design.execute "InsertElement 'TextQuestion', nil"
		@design.execute "InsertElement 'TextQuestion', nil"

		elA = @design.elements[0]
		elB = @design.elements[1]
		
		assert_equal(0, elA.position)
		assert_equal(1, elB.position)
		assert_not_equal(elA.id, elB.id)

		@design.execute "InsertElement 'TextQuestion', '#{elB.id}'"

		elC = @design.elements[1]
		
		assert_not_same(elA, elB)
		assert_not_same(elA, elC)
		assert_not_same(elB, elC)

		assert_equal(0, elA.position)
		assert_equal(1, elC.position)
		assert_equal(2, elB.position)

	end

	def test_delete_element
		
		# insert element
		@design.execute "InsertElement 'Question', nil"

		# get ids of inserted element
		id0 = @design.elements[0].id

		# delete element by id
		@design.execute "DeleteElement \"#{id0}\""

		# second command is a delete
		del = @design.commands[1]
		assert_kind_of(DeleteElementCommand, del)
		assert_equal(@design, del.design)
		assert(del.done)

		# none left
		assert_equal(0, @design.elements.length)


	end

	def test_undo_delete


		# two insert commands
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"

		# get ids of inserted elements
		id0 = @design.elements[0].id
		id1 = @design.elements[1].id

		assert_equal(0, @design.elements[0].position)
		assert_equal(1, @design.elements[1].position)

		# delete the first element by id
		@design.execute "DeleteElement \"#{id0}\""

		# third command is a delete
		assert_kind_of(DeleteElementCommand, @design.commands[2])
		assert_equal(@design, @design.commands[1].design)
		assert(@design.commands[1].done)

		# 1 element left
		assert_equal(1, @design.elements.length)
		assert_equal(0, @design.elements[0].position)

		@design.set_rollback_point

		# delete second element by id
		@design.execute("DeleteElement \"#{id1}\"")

		# no elements left
		assert_equal(0, @design.elements.length)

		# undo last command
		@design.rollback

		# only three commands left
		assert_equal(3, @design.commands.length)

		# element reinstated
		assert_equal(1, @design.elements.length)
		assert_equal(0, @design.elements[0].position)

	end
	
	def test_promote_element

		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		
		el0 = @design.elements[0]
		el1 = @design.elements[1]
		
		assert_equal(0, el0.position)
		assert_equal(1, el1.position)
		
		@design.set_rollback_point
		
		@design.execute("PromoteElement \"#{el1.id}\"")

		assert_equal(1, el0.position)
		assert_equal(0, el1.position)

		@design.rollback
		assert_equal(0, el0.position)
		assert_equal(1, el1.position)
		
	end
	
	def test_demote_element

		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		
		el0 = @design.elements[0]
		el1 = @design.elements[1]
		
		assert_equal(0, el0.position)
		assert_equal(1, el1.position)
		

		@design.set_rollback_point

		@design.execute("DemoteElement \"#{el0.id}\"")

		assert_equal(1, el0.position)
		assert_equal(0, el1.position)

		@design.rollback
		assert_equal(0, el0.position)
		assert_equal(1, el1.position)
		
	end

	def test_set_property
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		
		el0 = @design.elements[0]
		el1 = @design.elements[1]

		assert_equal(2, @design.commands.length)

		el0.set_property("text", "dog")
		
		assert_equal(3, @design.commands.length)
		assert_equal("dog", el0.text)

		el0.set_property("text", "dog")
		assert_equal(3, @design.commands.length)
		assert_equal("dog", el0.text)

		@design.set_rollback_point

		el0.set_property("text", "cat")
		assert_equal(4, @design.commands.length)
		assert_equal("cat", el0.text)
		
		@design.rollback
		assert_equal(3, @design.commands.length)
		assert_equal("dog", el0.text)
		
		
	end
	
	def test_find_previous_and_next_elements
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		
		el0 = @design.elements[0]
		el1 = @design.elements[1]
		el2 = @design.elements[2]
		
		assert_equal(0, el0.position)
		assert_equal(1, el1.position)
		assert_equal(2, el2.position)

		assert_equal(el0, el1.one_before)
		assert_equal(el1, el0.one_after)
		assert_equal(el2, el1.one_after)
		
	end

	def test_yaml_serialize_and_deserialize_design

		@design.execute "InsertElement 'TextQuestion', nil"		
		assert_equal(1, @design.elements.length)

		data = YAML.dump(@design)
		
		d = YAML.load(data)
		
		assert_kind_of Design, d
		
		assert_equal(1, d.elements.length)

	end

	def test_pages_can_be_counted

		make_three_pages
		assert_equal(3, @design.number_of_pages)

		@design.execute "InsertElement 'PageBreak', nil"
		assert_equal(4, @design.number_of_pages)

	end

	def test_get_pages_of_questions

		
		make_three_pages
	
		page = @design.get_page_of_contents(0)
		assert_equal(1, page.size)
	
		page = @design.get_page_of_contents(1)
		assert_equal(2, page.size)
	
		page = @design.get_page_of_contents(2)
		assert_equal(3, page.size)
	
	end

	def test_validate_text_question
		@design.execute "InsertElement 'TextQuestion', nil"
		q = @design.last_element_added
	end


	def test_questions_contribute_response_column_headers
		q = TextQuestion.new
		q.text = "how r u?"
		cols = q.response_column_headers
		assert_equal ["how r u?"], q.response_column_headers

		q = ListQuestion.new
		q.text = "how r u?"
		assert_equal ["how r u?"], q.response_column_headers

		q = MatrixQuestion.new
		q.question_parts = "how r u?\nhow do u do?"
		assert_equal ["how r u?", "how do u do?"], q.response_column_headers

	end

	def test_list_question_contributes_response_column_headers
		q = ListQuestion.new
		q.style = "radios"
		q.text = "how r u?"
		cols = q.response_column_headers
		assert_equal ["how r u?"], cols
	end

	private 
	def make_three_pages
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'PageBreak', nil"
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'PageBreak', nil"
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
		@design.execute "InsertElement 'Question', nil"
	end

end
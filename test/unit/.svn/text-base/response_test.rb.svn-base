require 'test_helper'

class ResponseTest < ActiveSupport::TestCase

	def setup
		@survey = Survey.new(:name=>"yin")
		@survey.save!
		@version = Version.new(:survey=>@survey)
		@version.save!

		@design = Design.new
		@design.elements << @q1 = TextQuestion.new
		@q1.text = "what's your name?"
		@design.elements << @q2 = TextQuestion.new 
		@q2.text = "how are you?"
		@version.design = @design
		@version.save!
		@survey.save!

		@survey.reload		
	end

	def test_response_belongs_to_a_version
		r = Response.for_version(@version, "1.2.3.4")
		r.save!
		@version.reload
		assert_equal @version, r.version
		assert_equal 1, @version.responses.count
	end

	def test_set_and_get_answers
		r = Response.for_version(@version, "1.2.3.4")
		r.set_answer(@q1, "adam")
		r.set_answer(@q2, "not bad thanks")
		r.save!
		r2 = Response.find(r.id)
		assert_equal("adam", r2.get_answer(@q1))
		assert_equal("not bad thanks", r2.get_answer(@q2))
	end

	def test_responses_counted_by_version_and_survey
		Response.for_version(@version, "0.0.0.0").save!
		assert_equal 1, @version.responses_count
		assert_equal 1, @version.survey.responses_count
	end
	
	def test_guid_populated_on_creation
		r = Response.for_version(@version, "0.0.0.0")
		assert_nil r.guid
		r.save!
		r.reload
		assert_not_nil r.guid		
	end
	
end
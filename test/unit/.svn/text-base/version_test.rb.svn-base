require 'test_helper'

class VersionTest < ActiveSupport::TestCase

	def setup
		@survey = Survey.new(:name=>"yin")
		@survey.save!
	end

	def test_created_in_initial_state
		v1 = Version.new
		assert_equal 1, v1.state
	end

	def test_accessing_version_in_design
		v1 = Version.new(:survey=>@survey)
		v1.save!
		
		assert_equal v1, @survey.version_in_design
		
	end


	def test_publish_and_archive
		
		# prior to publication survey's status should be "never published"
		assert_equal "never published", @survey.status
		
		v1 = Version.new(:survey=>@survey)
		v1.publish!
		
		@survey.reload
		
		# v1 should now be live
		assert_equal 2, v1.state
		assert_equal v1, @survey.live_version

		# next version should be created in design
		assert_equal 2, @survey.versions.size
		v2 = @survey.version_in_design
		assert_not_nil v2
		assert_not_equal v1, v2
		assert_equal 2, v2.position
		
		# survey's status should reflect live version
		assert_equal "version 1 live", @survey.status
		
		# when v2 is published...
		v2.publish!
		v1.reload
		v2.reload
		@survey.reload
		
		# ... v1 should go to archive,
		assert_equal 3, v1.state
		
		# ... v2 should be live
		assert_equal v2, @survey.live_version

		# ... and v3 should be created in design
		v3 = @survey.version_in_design
		assert_not_nil v3
		assert_not_equal v2, v3
		assert_equal 3, v3.position
		
		# when v2 is archived...
		v2.archive!
		v2.reload
		v3.reload
		@survey.reload
		
		# ... it's state should change,
		assert_equal 3, v2.state
		
		# ... live version should be nil,
		assert_nil @survey.live_version
		
		# ... no new version should be created
		assert_equal 3, @survey.versions.size
		
		# ... and survey's status should reflect that there's no live version
		assert_equal "version 2 archived", @survey.status
		
	end
	
	def test_saving_and_reloading_design
		v1 = Version.new(:survey=>@survey)
		v1.design = Design.new
		v1.save!

		v1.reload
		assert_not_nil v1.design
		
		assert_kind_of Design, v1.design
	end
	
	def test_design_copied_when_creating_new_version
		v1 = Version.new(:survey=>@survey)
		v1.design = Design.new
		v1.save!
		v1.publish!
		v1.reload
		@survey.reload
		v2 = @survey.version_in_design
		assert_not_equal v1, v2
		
		assert_equal 1, v1.position
		assert_equal 2, v2.position
		assert_not_nil v2.design
		assert_kind_of Design, v2.design
		assert_not_equal v1.design, v2.design
		assert_equal v1.design.to_yaml, v2.design.to_yaml
		
		
	end
	

end

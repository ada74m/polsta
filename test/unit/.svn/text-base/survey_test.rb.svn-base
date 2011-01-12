require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

	def test_enforcement_of_unique_names_within_user_scope
		bob = User.new("bob@polsta.net", "bob", "letmein" )
		jim = User.new("jim@polsta.net", "jim", "letmein" )
		bob.save!
		jim.save!
		
		first_for_bob = Survey.new(:name=>"my survey", :user=>bob)
		second_for_bob = Survey.new(:name=>"my survey", :user=>bob)
		first_for_jim = Survey.new(:name=>"my survey", :user=>jim)
		
		first_for_bob.save!
		assert_raise ActiveRecord::RecordInvalid do
			second_for_bob.save!
		end
		
		first_for_jim.save!
	end

	def test_url_name_set_on_creation
		survey = Survey.new(:name=>"a beautiful survey")
		survey.save!
		assert_equal "a-beautiful-survey", survey.url_name
	end

	def test_url_name_duplicates_avoided_within_scope_of_one_user
		bob = User.new("bob@polsta.net", "bob", "letmein" )

		s0 = Survey.new(:name=>"my survey", :user=>bob)
		s1 = Survey.new(:name=>"my-survey", :user=>bob)
		s0.save!
		s1.save!
		assert_equal "my-survey", s0.url_name
		assert_equal "my-survey-1", s1.url_name
	end

	def test_url_name_duplicates_allowed_between_two_users
		bob = User.new("bob@polsta.net", "bob", "letmein" )
		jim = User.new("jim@polsta.net", "jim", "letmein" )

		s0 = Survey.new(:name=>"my survey", :user=>bob)
		s1 = Survey.new(:name=>"my survey", :user=>jim)

		s0.save!
		s1.save!

		assert_equal "my-survey", s0.url_name
		assert_equal "my-survey", s1.url_name
	end

	def test_has_a_list_of_versions
		survey = Survey.new(:name=>"yin")
		survey.save!
		assert_not_nil survey.versions

		first_version = Version.new(:survey=>survey)
		second_version = Version.new(:survey=>survey)
		
		first_version.save!
		second_version.save!
		
		assert_equal 2, survey.versions.size

		assert_equal first_version, survey.versions[0]
		assert_equal 1, first_version.position

		assert_equal second_version, survey.versions[1]
		assert_equal 2, second_version.position
	end


end
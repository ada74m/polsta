require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def test_create_user
		bob = User.new("bob@polsta.net", "bob", "letmein" )
		bob.save!
		
		robert = User.find bob.id
		assert_equal bob.email, robert.email
		assert_equal bob.account_name, robert.account_name
	end
	
	
	def test_missing_email
		bob = User.new("", "bob", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "can't be blank", bob.errors["email"]
	end
	
	def test_repeated_email
		bob = User.new("bob@polsta.net", "bob", "letmein")
		bob.save!
	
		robert = User.new("bob@polsta.net", "bob", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			robert.save!
		end
		assert_equal "has already been taken", robert.errors["email"]
	end

	def test_badly_formed_email
		bob = User.new("bob at rest", "bob", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "is invalid", bob.errors["email"]
	end
	
	def test_missing_account_name
		bob = User.new("bob@polsta.net", "", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "can't be blank", bob.errors["account_name"]
	end
	
	def test_repeated_account_name
		bob = User.new("bob@polsta.net", "bob", "letmein")
		bob.save!
	
		robert = User.new("robert@polsta.net", "bob", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			robert.save!
		end
		assert_equal "has already been taken", robert.errors["account_name"]
	end
	
	def test_too_long_account_name
		bob = User.new("bob@polsta.net", "123456789012345678901234567890", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "is too long (maximum is 20 characters)", bob.errors["account_name"]
	end
	
	def test_too_short_account_name
		bob = User.new("bob@polsta.net", "12", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "is too short (minimum is 3 characters)", bob.errors["account_name"]
	end
	
	def test_badly_formed_account_name
		bob = User.new("bob@polsta.net", "bob is the best", "letmein")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "can only contain numbers and lower-case letters", bob.errors["account_name"]
	end
	
	def test_missing_password
		bob = User.new("bob@polsta.net", "bob", "")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "can't be blank", bob.errors["password"]
	end	
	
	
	def test_too_long_password
		bob = User.new("bob@polsta.net", "bob", "123456789012345678901234567890")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "is too long (maximum is 16 characters)", bob.errors["password"]
	end
	
	def test_too_short_password
		bob = User.new("bob@polsta.net", "bob", "12345")
		assert_raise ActiveRecord::RecordInvalid do
			bob.save!
		end
		assert_equal "is too short (minimum is 6 characters)", bob.errors["password"]
	end

	def test_password_hash_and_salt_set_on_create
		password = "letmein"
		
		bob = User.new("bob@polsta.net", "bob", password)
		bob.save!
		bob.reload
		
		salt = bob.password_salt
		hash = bob.password_hash
		
		assert_not_nil salt
		assert_not_nil hash

		assert_equal Digest::SHA256.hexdigest(password + salt), hash
	end
	
	def test_accept_terms_after_create
		bob = User.new("bob@polsta.net", "bob", "letmein")
		bob.save!
		robert = User.find bob.id
		assert !robert.has_accepted_terms?
		robert.has_accepted_terms = true
		robert.save!
		robert.reload
		assert robert.has_accepted_terms?
	end

	def test_authenticate_user_once_created
		bob = User.new("bob@polsta.net", "bob", "letmein")
		bob.save!
		
		user = User.authenticate("bob@polsta.net", "letmein")
		assert_equal bob.id, user.id
	end


	def test_fail_to_authenticate_user_with_wrong_password
		bob = User.new("bob@polsta.net", "bob", "comingin")
		bob.save!
		
		user = User.authenticate("bob@polsta.net", "letmein")
		assert_nil user
	end

	def test_fail_to_authenticate_user_with_unknown_email
		bob = User.new("jim@polsta.net", "bob", "letmein")
		bob.save!
		
		user = User.authenticate("bob@polsta.net", "letmein")
		assert_nil user
	end
	
	
	def test_has_many_surveys
		bob = User.new("jim@polsta.net", "bob", "letmein")
		bob.save!
		assert_not_nil bob.surveys

		first_survey = Survey.new(:name=>"a one", :user=>bob)
		second_survey = Survey.new(:name=>"a two", :user=>bob)
		
		first_survey.save!
		second_survey.save!
		
		assert_equal 2, bob.surveys.size
	end

end

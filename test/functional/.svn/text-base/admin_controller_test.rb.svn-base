require 'test_helper'

class AdminControllerTest < ActionController::TestCase

	def setup
		#@controller = TagsController.new
		#@request    = ActionController::TestRequest.new
		#@response   = ActionController::TestResponse.new
		
		User.new("ada@polsta.net", "ada", "letmein").save!
		@user_id = User.find_by_account_name("ada")
		
	end

	def test_index_shown_when_not_logged_in
		get :index
		assert_response :success
	end
	
	def test_redirect_to_list_when_user_logged_in
		get :index, {}, { :user=>@user_id }
		assert_redirected_to :action => 'list'
	end
	
	def test_list_redirects_to_login_if_no_user
		get :list
		assert_redirected_to :controller => 'user', :action => 'signin'
	end
	
	def test_list_renders_when_user_logged_in
		get :list, {}, { :user=>@user_id }
		assert_response :success
		assert_template "list"
	end
	
end

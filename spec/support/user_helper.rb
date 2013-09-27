module UserHelper
	def one_user
		FactoryGirl.create(:user)
	end

	def user_login
		one_user
		visit login_path
		fill_in 'session_username', with: 'username'
		fill_in 'session_password', with: "password"
		click_button 'Login'
	end
end
module UserHelper
	def one_user
		@attr = {
			:first_name =>  'first',
			:last_name =>  'last',
			:zipcode =>  '60060',
			:username =>  'username',
			:email =>  "email@email.com",
			:password =>  "password",
		}
		# User.create(@attr)
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
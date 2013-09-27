module UserHelper
	def one_user
		@attr = {
			:first_name =>  'first',
			:last_name =>  'last',
			:zipcode =>  '60060',
			:username =>  'username',
			:email =>  "email@email.com",
			:password =>  "password",
			:password_confirmation =>  "password",
		}
		User.create(@attr)
	end
end
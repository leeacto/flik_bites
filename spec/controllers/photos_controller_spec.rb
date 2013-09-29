describe PhotosController do
	it "should be able to attach a file" do
		@user = FactoryGirl.create(:user)
		post :update,{format: "#{@user.id}"}
		@user.reload.is_active?.should eq false
		session[:user_id].should eq nil
		response.should redirect_to(root_path)	
	end
end
require 'spec_helper'
require 'factory_girl_rails'


describe "Users" do
  
  describe "logon" do
  	it "logs in with succesful login" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		current_path.should == "/home"
  	end

  	it "doesn't login with incorrect parameters" do
  		@user1 = FactoryGirl.create(:user)
	  	visit "/"
	  	fill_in "user_session_username", with: "john"
	  	fill_in "user_session_password", with: "pass1"
	  	click_button "Login"
	  	current_path.should == "/"
  	end

  end

  describe "home page" do
  	it "goes to profile page" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		click_link(@user1.username)
  		current_path.should == "/users/1"
  	end

  	it "logs out" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		click_link("Logout")
  		current_path.should == "/"
  	end

  	it "goes to event" do
  		@user1 = FactoryGirl.create(:user)
  		@event1 = FactoryGirl.create(:event)
  		sign_in()
  		click_link("Details")
  		current_path.should == "/events/1"

  	end

  	it "follows event" do
  		@user1 = FactoryGirl.create(:user)
  		@event1 = FactoryGirl.create(:event)
  		sign_in()
  		click_link("Details")
  		click_link("Follow")
  		current_path.should == '/events/1'
  		@user1.events.first.should == @event1

  	end

  end

	


  def sign_in()	
  	visit "/"
  	fill_in "user_session_username", with: "john"
  	fill_in "user_session_password", with: "pass"
  	click_button "Login"
  end


end

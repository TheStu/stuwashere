require 'spec_helper'

describe "Authentication" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    post = FactoryGirl.create(:post)
    tag = FactoryGirl.create(:tag)
    FactoryGirl.create(:tagging, tag: tag, post: post)
    FactoryGirl.create(:picture)
  end

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_selector('h2',    text: 'Sign in') }

    describe "and sign in via form" do
      before do
        fill_in "user_email", :with => user.email
        fill_in "user_password", :with => user.password
        click_button "Sign in"
      end

      it { should have_content("Signed in successfully.") }

    end

    describe "should not allow an unregistered user to sign in" do
      before do
        fill_in "user_email", :with => "notarealuser@example.com"
        fill_in "user_password", :with => "fakepassword"
        click_button "Sign in"
      end

      it { should_not have_content("Signed in successfully.") }

    end
  end

  describe "signin" do
    before { visit new_user_session_path }

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(full_title('home')) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should_not have_link('New Trip') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      #describe "when attempting to visit a protected page" do
      #  before { visit edit_user_registration_path(user) }

      #  describe "after signing in" do
      #    before do
      #      fill_in "user_email",    with: user.email
      #      fill_in "user_password", with: user.password
      #      click_button "Sign in"
      #    end

      #    it "should render the desired protected page" do
      #      page.should have_selector('h2', text: 'Edit User')
      #    end
      #  end
      #end

      describe "in the Users controller" do

        describe "submitting to the update action" do
          before { put user_registration_path(user) }
          specify { response.status.should eq(401) }
        end

        describe "submit to the delete action" do
          before { delete user_registration_path(user) }
          specify { response.status.should eq(401) }
        end
      end
    end
  end
end

require 'spec_helper'

describe "picture Pages" do

  subject { page }

  before do
    post = FactoryGirl.create(:post)
    tag = FactoryGirl.create(:tag)
    FactoryGirl.create(:tagging, tag: tag, post: post)
    FactoryGirl.create(:picture)
  end

  describe "while signed in" do

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "picture creation" do

      before do
        FactoryGirl.create(:trip)
        FactoryGirl.create(:gear_item)
        visit new_picture_path
      end

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New picture') }
      end

      describe "with valid information" do
        before do
          select "Lorem Trip", from: 'Trip'
          fill_in 'picture_name', with: 'Lorem'
          fill_in 'picture_flickr_url', with: 'http://www.flickr.com/photos/manuelrobert/7741362602/'
          fill_in 'picture_description', with: 'Lorem Ipsum'
        end
        it "should create picture" do
          expect { click_button 'Create Picture' }.to change(Picture, :count).by(1)
        end
      end
    end

    describe "edit picture" do

      before do
        picture = FactoryGirl.create(:picture)
        visit edit_picture_path(picture)
        fill_in "Name", with: "New Name"
        click_button "Update Picture"
      end

      it { should have_selector('h1', text: "New Name")}

    end

    describe "visit picture page" do

      before do
        picture = FactoryGirl.create(:picture)
        visit picture_path(picture)
      end

      it "should delete picture" do
        expect { click_link 'Destroy' }.to change(Picture, :count).by(-1)
      end
    end

    describe "show picture" do

      before do
        picture = FactoryGirl.create(:picture)
        visit picture_path(picture)
      end

      it { should have_selector('h1', text: 'Lorem Picture') }
      it { should have_content('Lorem Ipsum') }

    end
  end

  describe "while not signed in" do
    describe "picture creation" do

      before { visit new_picture_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post pictures_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit picture" do

      before do
        picture = FactoryGirl.create(:picture)
        visit edit_picture_path(picture)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        picture = FactoryGirl.create(:picture)
        put picture_path(picture)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete picture link" do
      before do
        picture = FactoryGirl.create(:picture)
        visit edit_picture_path(picture)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        picture = FactoryGirl.create(:picture)
        delete picture_path(picture)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

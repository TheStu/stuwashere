require 'spec_helper'

describe "Tag Pages" do

  subject { page }

  before do
    tag = FactoryGirl.create(:tag)
    tag = FactoryGirl.create(:tag)
    FactoryGirl.create(:tagging, tag: tag, tag: tag)
    FactoryGirl.create(:picture)
  end

  describe "while signed in" do

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "Tag creation" do

      before do
        visit new_tag_path
      end

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New Tag') }
      end

      describe "with valid information" do
        before do
          fill_in 'Name', with: 'Lorem'
        end
        it "should create Tag" do
          expect { click_button 'Create Tag' }.to change(Tag, :count).by(1)
        end
      end
    end

    describe "edit Tag" do

      before do
        tag = FactoryGirl.create(:tag)
        visit edit_tag_path(tag)
        fill_in "Name", with: "New Name"
        click_button "Update Tag"
      end

      it { should have_content('New Name')}

    end

    describe "visit Tag page" do

      before do
        tag = FactoryGirl.create(:tag_photo)
        visit tag_path(tag)
      end

      it "should delete Tag" do
        expect { click_link 'Destroy' }.to change(Tag, :count).by(-1)
      end
    end

    describe "show Tag" do

      before do
        tag = FactoryGirl.create(:tag_photo)
        post = FactoryGirl.create(:post)
        FactoryGirl.create(:tagging, tag: tag, post: post)
        visit tag_path(tag)
      end

      it { should have_selector('h1', text: 'Photo') }
      it { should have_selector('h3', text: 'Lorem Post') }
      it { should have_content('Lorem Ipsum') }

    end
  end

  describe "while not signed in" do
    describe "Tag creation" do

      before { visit new_tag_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post tags_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit Tag" do

      before do
        tag = FactoryGirl.create(:tag)
        visit edit_tag_path(tag)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        tag = FactoryGirl.create(:tag)
        put tag_path(tag)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete Tag link" do
      before do
        tag = FactoryGirl.create(:tag)
        visit edit_tag_path(tag)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        tag = FactoryGirl.create(:tag)
        delete tag_path(tag)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

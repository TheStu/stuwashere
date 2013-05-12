require 'spec_helper'

describe "Post Pages" do

  subject { page }

  let(:tag) { FactoryGirl.create(:tag) }

  before do
    post = FactoryGirl.create(:post)
    FactoryGirl.create(:tagging, tag: tag, post: post)
    FactoryGirl.create(:picture)
  end

  describe "while signed in" do

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "Post creation" do

      before do
        FactoryGirl.create(:trip)
        FactoryGirl.create(:gear_item)
        visit new_post_path
      end

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New Post') }
      end

      describe "with valid information" do
        before do
          check 'Gear Review'
          select 'Lorem Gear Item', from: 'Gear item'
          select 'Lorem Trip', from: 'Trip'
          fill_in 'Title', with: 'Lorem'
          fill_in 'Content', with: 'Lorem Ipsum'
        end
        it "should create Post" do
          expect { click_button 'Create Post' }.to change(Post, :count).by(1)
        end
      end
    end

    describe "edit Post" do

      before do
        post = FactoryGirl.create(:post)
        visit edit_post_path(post)
        fill_in "Title", with: "New Title"
        click_button "Update Post"
      end

      it { should have_content('New Title')}

    end

    describe "visit Post page" do

      before do
        post = FactoryGirl.create(:post)
        visit post_path(post)
      end

      it "should delete Post" do
        expect { click_link 'Destroy' }.to change(Post, :count).by(-1)
      end
    end

    describe "show Post" do

      before do
        gear_item = FactoryGirl.create(:gear_item)
        post = FactoryGirl.create(:post_with_gear_item, gear_item: gear_item)
        FactoryGirl.create(:tagging, tag: tag, post: post)
        visit post_path(post)
      end

      it { should have_selector('h1', text: 'Lorem Post') }
      it { should have_selector('a', text: 'Gear Review') }
      it { should have_selector('a', text: 'Lorem Gear Item') }
      it { should have_content('Lorem Ipsum') }

    end
  end

  describe "while not signed in" do
    describe "Post creation" do

      before { visit new_post_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post posts_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit Post" do

      before do
        post = FactoryGirl.create(:post)
        visit edit_post_path(post)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        post = FactoryGirl.create(:post)
        put post_path(post)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete Post link" do
      before do
        post = FactoryGirl.create(:post)
        visit edit_post_path(post)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        post = FactoryGirl.create(:post)
        delete post_path(post)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

require 'spec_helper'

describe "Gear Item Pages" do

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

    describe "gear item creation" do

      before { visit new_gear_item_path }

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New Gear Item') }
      end

      describe "with valid information" do
        before do
          fill_in 'gear_item_name', with: 'Lorem'
          fill_in 'gear_item_weight', with: 800
          fill_in 'gear_item_intro', with: 'Lorem Ipsum'
        end
        it "should create gear item" do
          expect { click_button 'Create Gear item' }.to change(GearItem, :count).by(1)
        end
      end
    end

    describe "edit gear item" do

      before do
        gear_item = FactoryGirl.create(:gear_item)
        visit edit_gear_item_path(gear_item)
        fill_in "Name", with: "New Name"
        click_button "Update Gear item"
      end

      it { should have_selector('h1', text: "New Name")}

    end

    describe "visit gear item page" do

      before do
        gear_item = FactoryGirl.create(:gear_item)
        visit gear_item_path(gear_item)
      end

      it "should delete gear item" do
        expect { click_link 'Destroy' }.to change(GearItem, :count).by(-1)
      end
    end

    describe "show gear item" do

      before do
        trip = FactoryGirl.create(:trip)
        list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        gear_item = FactoryGirl.create(:gear_item)
        FactoryGirl.create(:gear_listing, gear_item: gear_item, gear_list: list)
        visit gear_item_path(gear_item)
      end

      it { should have_selector('h1', text: 'Lorem Gear Item') }
      it { should have_selector('h3', text: 'Used On') }

    end
  end

  describe "while not signed in" do
    describe "gear item creation" do

      before { visit new_gear_item_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post gear_items_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit gear item" do

      before do
        gear_item = FactoryGirl.create(:gear_item)
        visit edit_gear_item_path(gear_item)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        gear_item = FactoryGirl.create(:gear_item)
        put gear_item_path(gear_item)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete gear item link" do
      before do
        gear_item = FactoryGirl.create(:gear_item)
        visit edit_gear_item_path(gear_item)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        gear_item = FactoryGirl.create(:gear_item)
        delete gear_item_path(gear_item)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

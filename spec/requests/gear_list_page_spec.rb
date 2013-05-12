require 'spec_helper'

describe "Gear List Pages" do

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

    describe "gear list creation" do

      before do
        FactoryGirl.create(:trip)
        FactoryGirl.create(:gear_item)
        visit new_gear_list_path
      end

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New Gear List') }
      end

      describe "with valid information" do
        before do
          fill_in 'gear_list_intro', with: 'Lorem Ipsum'
          select 'Lorem Gear Item', from: 'Gear item'
          select 'Carrying', from: 'Group type'
          select 'Lorem Trip', from: 'Trip'
          fill_in 'Quantity', with: '1'
        end
        it "should create gear list" do
          expect { click_button 'Create Gear list' }.to change(GearList, :count).by(1)
        end
      end
    end

    describe "edit gear list" do

      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        visit edit_gear_list_path(gear_list)
        fill_in "Intro", with: "New Intro"
        click_button "Update Gear list"
      end

      it { should have_content('New Intro')}

    end

    describe "visit gear list page" do

      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        visit gear_list_path(gear_list)
      end

      it "should delete gear list" do
        expect { click_link 'Destroy' }.to change(GearList, :count).by(-1)
      end
    end

    describe "show gear list" do

      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        gear_item = FactoryGirl.create(:gear_item)
        FactoryGirl.create(:gear_listing, gear_item: gear_item, gear_list: gear_list)
        visit gear_list_path(gear_list)
      end

      it { should have_selector('h1', text: 'Lorem Trip Gear List') }
      it { should have_selector('a', text: 'Lorem Trip Main Page') }
      it { should have_selector('h3', text: 'Carrying') }
      it { should have_selector('a', text: 'Lorem Gear Item') }

    end
  end

  describe "while not signed in" do
    describe "gear list creation" do

      before { visit new_gear_list_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post gear_lists_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit gear list" do

      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        visit edit_gear_list_path(gear_list)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        put gear_list_path(gear_list)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete gear list link" do
      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        visit edit_gear_list_path(gear_list)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        delete gear_list_path(gear_list)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

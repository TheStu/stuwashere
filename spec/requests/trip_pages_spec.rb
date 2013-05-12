require 'spec_helper'

describe "Trip Pages" do

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

    describe "trip creation" do

      before do
        visit new_trip_path
      end

      describe "should load correctly" do
        it { should have_selector('h1', text: 'New Trip') }
      end

      describe "with valid information" do
        before do
          fill_in 'Start date', with: '01-05-2013'
          fill_in 'End date', with: '01-10-2013'
          fill_in 'Name', with: 'Lorem'
          fill_in 'Intro', with: 'Lorem Ipsum'
        end
        it "should create trip" do
          expect { click_button 'Create Trip' }.to change(Trip, :count).by(1)
        end
      end
    end

    describe "edit trip" do

      before do
        trip = FactoryGirl.create(:trip)
        visit edit_trip_path(trip)
        fill_in "Name", with: "New Name"
        click_button "Update Trip"
      end

      it { should have_content('New Name')}

    end

    describe "visit trip page" do

      before do
        trip = FactoryGirl.create(:trip)
        visit trip_path(trip)
      end

      it "should delete trip" do
        expect { click_link 'Destroy' }.to change(Trip, :count).by(-1)
      end
    end

    describe "show trip" do

      before do
        trip = FactoryGirl.create(:trip)
        gear_list = FactoryGirl.create(:gear_list_with_trip, trip: trip)
        FactoryGirl.create(:post_with_trip, trip: trip)
        visit trip_path(trip)
      end

      it { should have_selector('h1', text: 'Lorem Trip') }
      it { should have_selector('a', text: 'Lorem Trip Gear List') }
      it { should have_selector('a', text: 'Lorem Post') }

    end
  end

  describe "while not signed in" do
    describe "trip creation" do

      before { visit new_post_path }
      it { should have_title(full_title('home')) }

    end

    describe "direct to create action" do
      before { post trips_path }
      specify { response.should redirect_to(root_path) }
    end

    describe "edit trip" do

      before do
        trip = FactoryGirl.create(:trip)
        visit edit_trip_path(trip)
      end

      it { should have_title(full_title('home')) }

    end

    describe "direct to update action" do
      before do
        trip = FactoryGirl.create(:trip)
        put trip_path(trip)
      end
      specify { response.should redirect_to(root_path) }
    end

    describe "delete trip link" do
      before do
        trip = FactoryGirl.create(:trip)
        visit edit_trip_path(trip)
      end

      it { should_not have_link('Destroy') }

    end

    describe "direct to delete action" do
      before do
        trip = FactoryGirl.create(:trip)
        delete trip_path(trip)
      end
      specify { response.should redirect_to(root_path) }
    end
  end
end

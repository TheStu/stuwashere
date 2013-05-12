require 'spec_helper'

describe "Static pages" do
  before do
    post = FactoryGirl.create(:post)
    tag = FactoryGirl.create(:tag)
    FactoryGirl.create(:tagging, tag: tag, post: post)
    FactoryGirl.create(:picture)
    trip = FactoryGirl.create(:trip)
    FactoryGirl.create(:gear_list, trip: trip)
  end

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_title(full_title('home'))}

  end

  describe "About" do
    before { visit about_path }

    it { should have_title(full_title('About'))}
    it { should have_selector('h1', text: 'About')}

  end

  describe "Contact" do
    before { visit contact_path }

    it { should have_title(full_title('Contact'))}
    it { should have_selector('h1', text: 'Contact')}

  end

  describe "Photography" do
    before { visit photography_path }

    it { should have_title(full_title('Photography'))}
    it { should have_selector('h1', text: 'Photography')}

  end

  describe "Web design" do
    before { visit web_design_path }

    it { should have_title(full_title('Web Design'))}
    it { should have_selector('h1', text: 'Web Design')}

  end

  #describe "Submit search form" do
  #  before do
  #    visit root_path
  #    fill_in "q", with: "Lorem"
  #    find('.navbar-search').submit_form!
  #    visit '/results?q=lorem'
  #  end

  #  it { should have_title(full_title('Search Results'))}
  #  it { should have_selector('h1', text: 'Lorem')}

  #end
end

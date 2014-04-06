require 'spec_helper'

describe "User pages" do
  subject { page }
  before(:all) { 30.times { FactoryGirl.create(:user) } }
  after(:all)  { User.delete_all }

  context "as standard user" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit user_path(user)
    end

    describe "profile page" do
      it { should have_css('h1', text: user.name) }
    end
  end

  context "as admin user" do
    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit users_path
    end

    describe "index" do

      it { should have_css('h1', text: 'All users') }
      it { should have_link('delete', href: user_path(User.first)) }
      it { should_not have_link('delete', href: user_path(admin)) }

      describe "pagination" do
        it { should have_selector('div.pagination') }

        it "should list each user" do
            User.paginate(page: 1).each do |user|
            page.should have_css('li', text: user.name)
          end
        end
      end

      it "should be able to delete another user" do
        expect { click_link('delete') }.to change(User, :count).by(-1)
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",           with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",  with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h2',    text: "Modify Your Details") }
      it { should have_selector('input', value: "Save Changes") }
    end

    describe "with invalid information" do
      before do
        fill_in 'Email', with: 'aaaaaaaaaaa'
        click_button "Save Changes"
      end
      it { should have_content('invalid') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Name",       with: new_name
        fill_in "Email",       with: new_email
        click_button "Save Changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end

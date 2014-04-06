require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:submit) { "Sign in" }

  describe "signin page" do
    before { visit signin_path }

      it { should have_selector('h1',    text: 'Sign in') }
      it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('h1', text: 'Sign in') }
      it { should have_css('div.alert.alert-danger', text: 'Invalid email / password combination') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_css('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      before { sign_in user }

      it { should have_selector('h2', text: "Welcome Back #{user.name}") }
      it { should have_link('My Profile', href: user_path(user)) }
      it { should have_link('My Details', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end

  describe "Authorisation" do
    describe "as non-admin users" do
      before { sign_in user }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_css('h2', text: 'Modify') }
        end

        describe "visiting the users index" do
          before { visit users_path }
          it { should have_content('Insufficient rights') }
        end

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Name",    with: user.name
            fill_in "Email", with: user.email
            click_button "Save Changes"
          end
          describe "after signing in" do
            it "should render the desired protected page" do
              page.should have_selector('div.alert.alert-success', text: 'Profile updated')
            end
          end
        end
      end
    end
  end
end

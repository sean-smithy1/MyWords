require 'spec_helper'

describe PasswordForm do

  before do
    @user=FactoryGirl.create(:user)
    @passchange = PasswordForm.new(@user)
  end

subject {@passchange}

  it { should respond_to(:original_password) }
  it { should respond_to(:new_password) }
  it { should respond_to(:new_password_confirmation) }

  describe "when original password is wrong" do
    before do
      @passchange.original_password = "foobut"
      @passchange.new_password = "foobar2"
      @passchange.new_password_confirmation = "foobar2"
    end

    it {should_not be_valid}
  end

  describe "when confirmation is wrong" do
    before do
      @passchange.original_password = "foobar"
      @passchange.new_password = "foobar2"
      @passchange.new_password_confirmation = "foobar3"
    end

    it {should_not be_valid}
  end

  it "should fail on password < 6"

  it "should pass original password correct"

  it "should change password"

end

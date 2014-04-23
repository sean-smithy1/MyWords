require 'spec_helper'

describe PasswordForm do

  before(:all) do
    @user=FactoryGirl.create(:user)
    @passform = PasswordForm.new(@user)
  end

subject {@passform}

  it { should respond_to(:original_password) }
  it { should respond_to(:new_password) }
  it { should respond_to(:new_password_confirmation) }

  describe "wrong original password" do
    before { @passform.original_password ="foobat" }
    it { should_not be_valid }
  end

  describe "wrong confirmation" do
    before { @passform.new_password_confirmation = "foobar3" }
    it { should_not be_valid }
  end

  describe "Password to short" do
    before { @passform.new_password = "foo" }
    it { should_not be_valid }
  end

  it "should change password"

end

require 'spec_helper'

describe ImportForm do

  before(:all) do
    @user=FactoryGirl.create(:user)
    @list=FactoryGirl.create(:list)
    @Import=ImportForm.new
  end

  describe "it imports into an existing list" do
    it "fails when words > maxwords"
    it "fails when there are duplicate words"
    it "fails when not the list owner"
    it "merges existing words"
  end

end


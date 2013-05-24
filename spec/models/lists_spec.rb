require 'spec_helper'

describe List do

  before do
    @list = List.new(listname: "Example_List", listtype:"u")
  end

  subject { @list }

  it { should respond_to(:listname) }
  it { should respond_to(:listtype) }

  describe "should accept s" do
    before { @list.listtype = "s" }
    it { should be_valid }
  end

  describe "should accept u" do
    before { @list.listtype = "u" }
    it { should be_valid }
  end

  describe "should not accept p" do
    before { @list.listtype = "p" }
    it { should_not be_valid }
  end

  describe "when list is not present" do
    before { @list.listname = " " }
    it { should_not be_valid }
  end
 
  describe "when listname is too long" do
    before { @list.listname = "a" * 46 }
    it { should_not be_valid }
  end
end

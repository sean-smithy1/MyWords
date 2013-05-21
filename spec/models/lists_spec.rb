require 'spec_helper'

describe List do

before do
  @list = List.new(listname: "Example_List")
  end

subject { @list }

  it { should respond_to(:listname) }


  describe "when list is not present" do
    before { @list.listname = " " }
    it { should_not be_valid }
  end
 
  describe "when listname is too long" do
    before { @list.listname = "a" * 51 }
    it { should_not be_valid }
  end


end

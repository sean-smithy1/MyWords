require 'spec_helper'

describe List do
  before do
    @list = List.new(listname: "Example_List", listtype:"u")
  end

  subject { @list }
  it { should respond_to(:listname, :listtype, :words) }

  describe "when list is not present" do
    before { @list.listname = " " }
    it { should_not be_valid }
  end

  describe "when listname is too long" do
    before { @list.listname = "a" * 46 }
    it { should_not be_valid }
  end
end

#Word Associations
describe "Creating or Associating Words" do
  before { @list1=FactoryGirl.create(:list_with_words, listname: "List1") }

  it "should create words not in the DB" do
    @list1.words.count.should == 6
  end

  pending ( it "should not allow duplicate words" ) do
    @list1.words << Word.new(word: "1_Word")
    it { should_not be_valid }
  end

  it "should associate words that exist in the DB" do
    list2=FactoryGirl.create(:list_with_words, listname: "List2")
    list2.words.count.should == 6
    Word.count == 6
  end
end

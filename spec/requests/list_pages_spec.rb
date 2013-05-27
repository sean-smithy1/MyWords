require 'spec_helper'

describe "List pages" do
  subject { page }
  let(:List) { FactoryGirl.create(:list) }

  describe "profile page" do
    let(:List) { FactoryGirl.create(:list) }
 
    before { visit user_path(list) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end

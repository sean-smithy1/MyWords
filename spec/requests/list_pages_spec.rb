require 'spec_helper'

describe "List pages" do
  subject { page }
  let(:list) { FactoryGirl.create(:list) }

  describe "List details page" do
    before { visit edit_list_path(list) }
    it { should have_field('list[listname]', text: list.listname ) }
  end
end

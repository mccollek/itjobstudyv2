# == Schema Information
#
# Table name: occupations
#
#  id            :integer          not null, primary key
#  code          :integer
#  name          :string(255)
#  display_level :integer
#  selectable    :boolean
#  sort_sequence :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Occupation do
  it "has a model factory" do
    FactoryGirl.create(:occupation).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:occupation, name: nil).should_not be_valid
  end
  it "is invalid without a code" do
    FactoryGirl.build(:occupation, code: nil).should_not be_valid
  end
  it "converts a BLS code from strings with hypen to an integer" do
    new_code = Occupation.convert_code '57-1111'
    new_code.should == 571111
  end

  it "returns the occupation's name as a string" do
    occ = FactoryGirl.create(:occupation)
    occ.to_s.should == occ.name
  end
end

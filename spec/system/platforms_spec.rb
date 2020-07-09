require 'rails_helper'

RSpec.describe Platform, type: :system do
  it "is valid if it has a name and a url" do
    platform = FactoryBot.build(:platform)
    expect(platform).to be_valid
  end

  it "is invalid if it doesn't have a name" do
    platform = FactoryBot.build(:platform, name: nil)
    platform.valid?
    expect(platform.errors[:name]).to include("can't be blank")
  end

  it "is invalid if it doesn't have a url" do
    platform = FactoryBot.build(:platform, url: nil)
    platform.valid?
    expect(platform.errors[:url]).to include("can't be blank")
  end
end

require 'rails_helper'

RSpec.describe Course, type: :system do
  it "is valid if it belongs to a platform and has a title and a url" do
    course = FactoryBot.build(:course)
    expect(course).to be_valid
  end

  it "is invalid if it doesn't belong to an platform" do
    course = FactoryBot.build(:course, platform: nil)
    course.valid?
    expect(course.errors[:platform]).to include("must exist")
  end

  it "is invalid if it doesn't have a title" do
    course = FactoryBot.build(:course, title: nil)
    course.valid?
    expect(course.errors[:title]).to include("can't be blank")
  end

  it "is invalid if it doesn't have a url" do
    course = FactoryBot.build(:course, url: nil)
    course.valid?
    expect(course.errors[:url]).to include("can't be blank")
  end

end

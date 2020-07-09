require 'rails_helper'

RSpec.describe Chapter, type: :system do
  it "is valid if it has a name and belongs to course" do
    chapter = FactoryBot.build(:chapter)
    expect(chapter).to be_valid
  end

  it "is invalid if it doesn't have a name" do
    chapter = FactoryBot.build(:chapter, name: nil)
    chapter.valid?
    expect(chapter.errors[:name]).to include("can't be blank")
  end

  it "is invalid if it doesn't belong to a course" do
    chapter = FactoryBot.build(:chapter, course: nil)
    chapter.valid?
    expect(chapter.errors[:course]).to include("must exist")
  end

end

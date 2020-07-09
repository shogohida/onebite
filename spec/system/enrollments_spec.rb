require 'rails_helper'

RSpec.describe Enrollment, type: :system do
  it "is valid if it has belongs to a course and a user" do
    enrollment = FactoryBot.build(:enrollment)
    expect(enrollment).to be_valid
  end

  it "is invalid if it doesn't belong to a user" do
    enrollment = FactoryBot.build(:enrollment, user: nil)
    enrollment.valid?
    expect(enrollment.errors[:user]).to include("must exist")
  end

  it "is invalid if it doesn't belong to a course" do
    enrollment = FactoryBot.build(:enrollment, course: nil)
    enrollment.valid?
    expect(enrollment.errors[:course]).to include("must exist")
  end

end

require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "Should raise error saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name:"Bork",school_email:"b@msudenver.edu",major:"BS")
    end
  end
end

require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "Should raise error saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",minor:"ET",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",school_email:"b@msudenver.edu",major:"BS",minor:"ET",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student without email" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"invalid-email",major:"BS",minor:"ET",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student with incorrect email" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",major:"BS",minor:"ET",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student without major" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",minor:"ET",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student without minor" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",graduation_date:"9/23/2024")
    end
  end
  test "Should raise error saving student without graduation date" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS")
    end
  end
end

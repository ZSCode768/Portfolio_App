require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "Should raise error saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",minor:"ET",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",school_email:"b@msudenver.edu",major:"BS",minor:"ET",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student without email" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"invalid-email",major:"BS",minor:"ET",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student with incorrect email" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",major:"BS",minor:"ET",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student without major" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",minor:"ET",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student without minor" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",graduation_date:"2024-09-23")
    end
  end
  test "Should raise error saving student without graduation date" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS")
    end
  end
  test "Should raise error saving student with a picture that is too large" do
    assert_raises ActiveRecord::RecordInvalid do
      #create large picture
      large_picture = StringIO.new("A" * 15.megabytes)
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",minor:"ET",profile_picture: {io: large_picture, filename: 'large_picture.png', content_type: 'image/png'})
    end
  end
  test "Should raise error saving student with the wrong file type" do
    assert_raises ActiveRecord::RecordInvalid do
      #create fake file
      wrong_file = StringIO.new("Fake Content")
      Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",minor:"ET",profile_picture: {io: wrong_file, filename: 'wrong_file.gif', content_type: 'image/gif'})
    end
  end
  test "Should set default profile picture when none is uploaded" do
    student = Student.create!(first_name:"Bark",last_name:"Bork",school_email:"b@msudenver.edu",major:"BS",minor:"ET",graduation_date:"2024-09-23")
    assert student.profile_picture.attached?, "Profile picture should be attached"

    assert_equal "default.png", student.profile_picture.filename.to_s, "The attached picture should be default.png"
    assert_equal "image/png", student.profile_picture.content_type, "The attached picture should be a png"
  end
end

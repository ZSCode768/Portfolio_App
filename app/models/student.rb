class Student < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "Must be an @msudenver.edu email!"}
    validates :major, presence: true
    validates :minor, presence: true
    validates :graduation_date, presence: true
end

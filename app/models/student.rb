class Student < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "Must be an @msudenver.edu email!"}
    validates :major, presence: true
    validates :minor, presence: true
    validates :graduation_date, presence: true
    has_one_attached:profile_picture
    validate :acceptable_image

    def acceptable_image
        return unless profile_picture.attached?
    
        unless profile_picture.blob.byte_size <= 1.megabyte
            errors.add(:profile_picture, "is too big")
        end
    
        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(profile_picture.content_type)
            errors.add(:profile_picture, "must be a JPEG or PNG")
        end
    end
end
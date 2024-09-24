class Student < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "Must be an @msudenver.edu email!"}
    validates :major, presence: true
    validates :minor, presence: true
    validates :graduation_date, presence: true
    has_one_attached :profile_picture
    validate :acceptable_image
    before_create :set_default_profile_picture

    def set_default_profile_picture
        unless profile_picture.attached?
            default_image_path = Rails.root.join("app", "assets", "images", "default.png")
            profile_picture.attach(io: File.open(default_image_path), filename: 'default.png', content_type: 'image/png')
        end
    end

    def acceptable_image
        return unless profile_picture.attached?
    
        unless profile_picture.blob.byte_size <= 10.megabyte
            errors.add(:profile_picture, "is too big")
        end
    
        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(profile_picture.content_type)
            errors.add(:profile_picture, "must be a JPEG or PNG")
        end
    end
end
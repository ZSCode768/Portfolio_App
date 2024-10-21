class Student < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "Must be an @msudenver.edu email!"}
    validates :major, presence: true
    validates :minor, presence: true
    validates :graduation_date, presence: true
    has_one_attached :image, dependent::purge_later
    # before_create :set_default_image
    validate :acceptable_image

    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS",
        "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major", "Any Major"]

    validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}
    # def set_default_image
    #     unless image.attached?
    #         default_image_path = Rails.root.join("app", "assets", "images", "default.png")
    #         image.attach(io: File.open(default_image_path), filename: 'default.png', content_type: 'image/png')
    #     end
    # end

    def acceptable_image
        return unless image.attached?
                  
        unless image.blob.byte_size <= 10.megabyte
            errors.add(:image, "file size is too big, must be under 10 MB.")
        end
    
        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(image.content_type)
            errors.add(:image, "must be a JPEG or PNG")
        end
    end
end
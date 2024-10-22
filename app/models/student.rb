class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :first_name, presence: true
    validates :last_name, presence: true
    # validates :school_email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "Must be an @msudenver.edu email!"}
    validate :email_format
    validates :major, presence: true
    validates :minor, presence: true
    validates :graduation_date, presence: true
    has_one_attached :image
    after_destroy :purge_image
    validate :acceptable_image

    #List of Valid Majors a student or employer can choose
    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS",
        "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]

    validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}

    #image purger for seeding
    private
    def purge_image
        image.purge_image if image.attached?
    end

    def email_format
        unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
            errors.add(:email, "Must be an @musdenver.edu email address")
        end
    end

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
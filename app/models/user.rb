class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates_presence_of :name
  validates_length_of :name, maximum: 50
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_length_of :password, minimum: 6, on: :create

  has_many :lists, :dependent => :destroy

  def my_lists(type)
    self.lists.where(listtype: type)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

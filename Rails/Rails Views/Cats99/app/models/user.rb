# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many(:cats, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat
  })

  has_many(:cat_rental_requests, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :CatRentalRequest
  })

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def self.find_by_credentials(username, password)
    user_check = User.where({username: username}).first
    return nil if user_check.nil?
    return user_check if user_check.is_password?(password)
    return nil
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :solutions
  has_and_belongs_to_many :contests
  validates :handle, format: {without: /\s/}
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def load_user_submition_count
    raise "Method not implemented yet"
  end

  def email_user
    email.split("@").first()
  end
end

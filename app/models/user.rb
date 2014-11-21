class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :category, foreign_key: "user_id", dependent: :destroy
  has_many :incexp, foreign_key: "user_id", dependent: :destroy
end

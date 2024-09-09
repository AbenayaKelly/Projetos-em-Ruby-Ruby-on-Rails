class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tasks, dependent:  :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password, confirmation: true, if: -> { password.present? }


end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nome, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
  def admin?
    self.admin
  end
  has_many :inscricoes,class_name: "Inscricao"
  has_many :eventos, through: :inscricoes

end

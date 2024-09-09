class Evento < ApplicationRecord
  has_many :inscricoes, class_name: "Inscricao"
  has_many :participantes, through: :inscricoes, source: :user # Um evento poderá ter muitos participantes
  validates :nome, presence: true
  validates :descricao, presence: true
  validates :data, presence: true

end


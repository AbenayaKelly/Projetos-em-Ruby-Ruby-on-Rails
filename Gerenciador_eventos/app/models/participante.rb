class Participante < ApplicationRecord
  belongs_to :evento # Cada participante poderá pertencer a um único evento

end

class HomeController < ApplicationController
  def index
    @eventos = Evento.all
  end
end

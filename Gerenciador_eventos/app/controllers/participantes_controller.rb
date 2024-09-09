class ParticipantesController < ApplicationController
  def new
    @participante = Participante.new
  end

  def create
    @participante = Participante.new(participante_params)
    if @participante.save
      redirect_to @participante.evento, notice: 'Inscrição realizada com sucesso.'
    else
      render :new
    end
  end

  private

  def participante_params
    params.require(:participante).permit(:nome, :email, :evento_id)
  end
end

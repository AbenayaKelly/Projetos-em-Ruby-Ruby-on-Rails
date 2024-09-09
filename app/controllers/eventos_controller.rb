class EventosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evento, only: [:show, :edit, :update, :destroy,:inscrever, :certificado]
  before_action :verify_admin,  only: [:new, :create, :edit, :update, :destroy]
  def index
    @eventos = Evento.all
  end
  def show
    @participantes = @evento.participantes
  end

  def new
    @evento = Evento.new
  end

  def create
    @evento = Evento.new(evento_params) #Cria um novo evento com parâmetros recebidos do formulário
    if @evento.save
      redirect_to @evento, notice: "Evento criado com sucesso!" # Usuário é redirecionado a pagina do evento
      return
      else
    render :new # redireciona o usuário ao formulário de criação para corrigir erros
    end
    end

def edit

end
def update
  if @evento.update(evento_params)
    redirect_to @evento, notice: 'Evento atualizado com sucesso.'
  else
    render :edit
  end
end

def destroy
  @evento.destroy
  redirect_to eventos_url, notice: 'Evento excluído com sucesso.'
end
  def certificado
    @evento = Evento.find(params[:id])
    @participante = @evento.participantes.find(params[:participante_id]) # Assumindo que o ID do participante foi passado na URL
    respond_to do |format|
      format.html
      format.pdf do
        pdf= generate_certificado_pdf(@evento,@participante)
        send_data pdf.render, filename: "certificado_#{@evento.nome}_#{@participante.nome}.pdf", type: 'application/pdf', disposition: 'attachment'
      end
    end
    end

  def inscrever
    puts "Evento: #{@evento.inspect}"
    puts "Participantes antes: #{@evento.participantes.pluck(:id).inspect}"
    if @evento.participantes.include?(current_user)
      redirect_to @evento, alert: 'Você já está inscrito neste evento.'
    else
      @evento.participantes << current_user
      redirect_to @evento, notice: 'Inscrição realizada com sucesso.'
    end
  end
  private
  def generate_certificado_pdf(evento, participante)
    Prawn::Document.new(page_size: 'A4', page_layout: :landscape)do
      page_width = 780
      page_height = 560
      image Rails.root.join('app', 'assets', 'images', 'moldura.jpg').to_s,
            at: [0, page_height], width: page_width, height: page_height,
            position: :center, fit: [page_width, page_height]

      text_box "Certificado de Participação",
      at: [0, page_height - 100],
        width: page_width,
        height: 50,
        size: 30,
        style: :bold,
        align: :center

      formatted_text = [
        {text:"Este certificado atesta que" },
        {text:" #{participante.nome}, ", styles:[:bold]},
        {text:"participou com êxito no evento "},
        {text:"#{evento.nome}", styles:[:bold]},
        {text:". O evento, foi realizado no dia #{Time.now.strftime('%d/%m/%Y')}. Parabenizamos sua presença."}
      ]
      # Configurando as margens da moldura
      left_margin =  80  # Margem esquerda para posicionar o texto dentro da moldura
      right_margin = 70  # Margem direita, se necessário
      top_margin = 200   # Margem superior ajustada
      text_width = page_width - left_margin - right_margin  # Largura do texto dentro da moldura



      formatted_text_box formatted_text,
        at: [left_margin, page_height - top_margin],  # Posição vertical e horizontal
        width: text_width,  # Ajuste a largura da caixa para forçar a quebra de linha
        height: 200,
        size: 18,
        align: :left,
        overflow: :shrink_to_fit  # Ajusta o texto dentro da caixa, quebrando linhas conforme necessário
      number_pages "Página <page> de <total>", { at: [350, 0], width: 350,  position: :center, size: 12 }

    end
  end

  def set_evento
  @evento = Evento.find(params[:id])
rescue ActiveRecord::RecordNotFound
  redirect_to eventos_path, alert: 'Evento não encontrado.'
end
  def verify_admin
    redirect_to root_path, alert: 'Acesso não autorizado!' unless current_user.admin?
  end
# Permit only the allowed parameters for evento
def evento_params
  params.require(:evento).permit(:nome, :descricao, :data)
end
end





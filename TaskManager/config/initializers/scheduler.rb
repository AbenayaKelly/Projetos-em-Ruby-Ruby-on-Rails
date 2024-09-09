# config/initializers/scheduler.rb
require 'rufus-scheduler'
  scheduler = Rufus::Scheduler.new

  # Agende a tarefa para rodar todos os dias
  scheduler.every '1m' do

    # Coloque aqui o código para verificar tarefas prestes a vencer e enviar notificações por email
    tasks_due_soon = Task.where(" due_date <= ? AND completed = ?" , Time.zone.now + 1.minutes, false )  # Exemplo de consulta para tarefas prestes a vencer

    tasks_due_soon.each do |task|
      TaskMailer.task_due_soon(task).deliver_now
      Rails.logger.info "Email de notificação enviado para #{task.user.email}"
    end

  end


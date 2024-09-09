# app/mailers/task_mailer.rb

class TaskMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def task_created(task)
    @task = task
    mail(to: @task.user.email, subject: "Tarefa  criada com sucesso")
  end

  def task_due_soon(task)
    @task = task
    mail(to: @task.user.email, subject: "Tarefa Prestes a Vencer")
  end
end



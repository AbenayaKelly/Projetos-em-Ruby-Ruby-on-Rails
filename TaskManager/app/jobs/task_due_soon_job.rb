class TaskDueSoonJob <ApplicationJob
  queue_as :default

  def perform
    tasks_due_soon = Task.where("due_date <= ?AND due_date >= ?", Time.now.end_of_day, Time.now)
    tasks_due_soon.each do |task|
      TaskMailer.task_due_soon(task).deliver_now
    end
  end

end
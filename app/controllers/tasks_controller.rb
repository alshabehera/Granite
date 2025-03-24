# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :load_task!, except: %i[index create]
  respond_to :html, :xml, :json
  rescue_from Pundit::NotAuthorizedError, with: :handle_authorization_error

  def index
    tasks = policy_scope(Task)
    tasks_with_assigned_user = tasks.as_json(include: { assigned_user: { only: %i[name id] } })
    render_json({ tasks: tasks_with_assigned_user })
  end

  def show
    authorize @task
  end

  def create
    task = current_user.created_tasks.new(task_params)
    authorize task
    task.save!
    render_notice("Task was successfully created")
  end

  def update
    authorize @task
    @task.update!(task_params)
    render_notice("Task was successfully updated!")
  end

  def destroy
    authorize @task
    @task.destroy!
    render_json
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end

    def handle_authorization_error
      render_error("Access denied. You are not authorized to perform this action.", :forbidden)
    end
end

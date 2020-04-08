class ProjectsController < ApiController
  def index
    @projects = Projects.where company: current_user.company

    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.find params[:id]

    render json: @project
  end

  def create
    project_data = params[:project].permit(:name, :customer_id, :address, :zip, :city, :description)
    project_data[:company_id] = current_user.company.id
    @project = Project.new project_data
    
    if @project.save!
      render json: @project
    else
      render json: {response: 'Record invalid'}, status: 400
    end
  end

  def update
    @project = Project.find params[:id]
    
    if @project.update(params)
      render json: @project
    else
      render json: {response: 'Record invalid'}, status: 400
    end
  end

  def destroy
    if Project.find(params[:id]).destroy!
      render json: {ok: true}
    else
      render json: {response: 'Record could net be deleted'}, status: 400
    end
  end
end

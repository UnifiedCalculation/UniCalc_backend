class FormsController < ApiController
  def index
    @forms = Form.where project_id: params[:project_id], status: params[:status].singularize

    render json: @forms
  end

  def show
    @form = Form.find params[:id]

    render json: @form
  end

  def create
    data = params.permit(:name, :project_id)
    
    @form = Form.new data
    @form.status = params[:status].singularize
    @form.employee = current_user.employee
    
    if @form.save!
      render json: @form
    else
      render json: {response: 'Record invalid'}, status: 400
    end
  end

  def update
    byebug
  end
end

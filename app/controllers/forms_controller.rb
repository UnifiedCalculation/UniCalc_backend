class FormsController < ApiController
  include ActiveModel::Serializers::JSON

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

  def destroy
    @form = Form.find(params[:id]).destroy

    render json: @form
  end

  def generate
    form = Form.find(params[:id])
    
    url = [Rails.configuration.pdf_generator_url, form.status].join('/')
    data = form.to_json(include: {entries: {include: :articles}})

    require "uri"
    require "net/http"

    request = Net::HTTP.post_form(URI.parse(url), data)
    puts request.body
  end
end

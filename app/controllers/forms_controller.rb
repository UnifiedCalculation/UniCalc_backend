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

  def update_status
    form = Form.find params[:id]

    updated_form = form.dup include: {entries: :articles_entries}
    updated_form.update status: params[:status].singularize

    rendern json: updated_form
  end

  def destroy
    @form = Form.find(params[:id]).destroy

    render json: @form
  end

  def generate
    form = Form.find(params[:form_id])
    
    url = [Rails.configuration.pdf_generator_url, form.status].join('/')

    company = form.project.company
    customer = form.project.customer

    data = {
      discount: form.discount,
      title: form.name,
      entries: [],
      projectInformation: {
        bankInformation: {
          additionalInformation: "#{form.project.name} #{form.status} #{Time.now}",
          alternativeProcedure: [
            'Name AV1: UV;UltraPay005;12345'
          ],
          invoiceInformation: '//S1/10/10201409/11/190512/20/1400.000-53/30/106017086/31/180508/32/7.7/40/2:10;0:30',
          paymentReference: '210000000003139471430009017'
        },
        company: {
          account: company.iban,
          address: company.address,
          city: company.city,
          contactPerson: customer.user.full_name,
          logo: "http://via.placeholder.com/350x150",
          land: 'Schweiz',
          mail: company.mail,
          name: company.name,
          phone: company.phone,
          url: company.url,
          zip: company.zip
        },
        customer: {
          address: customer.address,
          city: customer.city,
          companyName: company.name,
          department: '',
          land: 'Schweiz',
          name: customer.user.full_name,
          zip: customer.zip
        }
      }
    }

    data[:discount] ||= 0

    form.entries.each do |entry|
      articles = []
      entry.articles_entries.each do |articles_entry|
        articles << {
          amount: articles_entry.amount,
          description: articles_entry.description,
          discount: articles_entry.discount,
          name: articles_entry.article.name,
          price: articles_entry.article.price,
          unit: articles_entry.article.unit
        }
      end
      data[:entries] << {
        title: entry.title,
        articles: articles
      }
    end

    require 'httparty'

    request = HTTParty.post url, body: data.to_json, headers: { 'Content-Type': 'application/json' }

    send_data request.body, filename: "#{form.status}_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.pdf", type: "application/pdf", disposition: "attachment"
  end
end

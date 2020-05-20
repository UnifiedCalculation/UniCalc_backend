class FormsController < ApiController
  include ActiveModel::Serializers::JSON

  def index
    @forms = Form.where project_id: params[:project_id], status: params[:status].singularize

    render json: @forms
  end

  def index_user
    @forms = Form.where project_id: params[:project_id], status: 'contract', employee: current_user.employee

    render json: @forms
  end

  def show
    @form = Form.find params[:id]

    render json: @form
  end

  def compare
    new_form = Form.find params[:contract_id]
    old_form = new_form.copied_from

    result = old_form.attributes
    result[:entries] = []

    old_form.entries.each_with_index do |old_entry, entry_index|
      break if entry_index >= new_form.entries.count

      result_entry = old_entry.attributes
      result_entry[:articles_entries] = []

      new_entry = new_form.entries[entry_index]

      old_entry.articles_entries.each_with_index do |old_article_entry, art_index|
        break if art_index >= new_entry.articles_entries.count

        new_article_entry = new_entry.articles_entries[art_index]

        result_entry[:articles_entries] << {
          amount: {
            old: old_article_entry.amount,
            new: new_article_entry.amount
          },
          article_id: old_article_entry.article_id,
          description: {
            old: old_article_entry.description,
            new: new_article_entry.description
          },
          discount: {
            old: old_article_entry.discount,
            new: new_article_entry.discount
          },
          entry_id: old_article_entry.entry_id,
          name: old_article_entry.article.name,
          price: old_article_entry.article.price,
          unit: old_article_entry.article.unit
        }
      end

      result[:entries] << result_entry
    end

    render json: result
  end

  def create
    data = params.permit(:name, :discount, :project_id)
    
    @form = Form.new data
    @form.status = params[:status].singularize
    @form.employee = current_user.employee
    @form.save!

    if params[:entries].present?
      params[:entries].each do |entry_data|
        entry_data[:form_id] = @form.id
        entry = Entry.create! entry_data.permit(:form_id, :title, :discount)

        if entry_data[:articles_entries].present?
          entry_data[:articles_entries].each do |articles_entry_data|
            articles_entry_data[:entry_id] = entry.id
            article_entry = ArticlesEntry.create! articles_entry_data.permit(:entry_id, :article_id, :amount, :description, :discount)
          end
        end
      end
    end
    
    render json: @form
  end

  def update_status
    form = Form.find params[:form_id]

    updated_form = form.deep_clone include: {entries: :articles_entries}
    updated_form.update! status: params[:status].singularize, employee: current_user.employee, copied_from: form

    render json: updated_form
  end

  def assigned_employee
    form = Form.find params[:form_id]
    form.update params.require(:form).permit(:employee_id)

    render json: form
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
          number: articles_entry.article.number,
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

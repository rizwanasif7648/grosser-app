# frozen_string_literal: true

class ReplenishmentsController < InheritedResources::Base
  skip_before_action :verify_authenticity_token, only: %i[uploadfiles removefiles]
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: %i[new edit index]
  before_action :sanitize_params, only: %i[create]
  after_action :save_uploads, only: %i[create]
  before_action :set_replenishment, only: %i[show]

  # GET /boxes
  def index
    authorize [current_user, 'Requisition'], policy_class: ApplicationPolicy
    @customer = current_customer
    @replenishments = @customer ? @customer.replenishments.order(created_at: :desc) : []
  end

  def new
    authorize [current_user, 'Requisition'], policy_class: ApplicationPolicy
    @replenishment = Replenishment.new
  end

  def create
    authorize [current_user, 'Requisition'], policy_class: ApplicationPolicy
    @replenishment = Replenishment.new(replenishment_params)
    if @replenishment.save
      flash[:notice] = 'Replenishment was successfully created.'
    else
      flash[:alert] = @replenishment.errors.full_messages.to_sentence
    end
    redirect_to replenishments_url
  end

  def show
    authorize [current_user, 'Requisition'], policy_class: ApplicationPolicy
    check_customer_authorication(current_user, @replenishment)
  end

  def uploadfiles
    @upload = Upload.create!(photo: params[:file], note: params[:note])
    render json: { id: @upload.id, photo: @upload.photo.url, note: @upload.note, status: :ok }
  end

  def removefiles
    Upload.find(params[:upload_id]).delete
    render json: { status: :ok }
  end

  def logbook
    @customer = current_customer
    @replenishments = @customer ? ReplenishmentLineItem.where(customer_id: @customer.id) : []

    box_replenishment
    product_replenishment
    @replenishments.order(created_at: :desc)
  end

  private

  def box_replenishment
    return unless params[:box_id].present?

    @box = Box.find(params[:box_id])
    @replenishments = ReplenishmentLineItem.where(customer_id: @customer.id, box_id: @box.id)
  end

  def product_replenishment
    return unless params[:product_id].present?

    @product = Product.find(params[:product_id])
    @replenishments = ReplenishmentLineItem.where(customer_id: @customer.id, box_id: @box.id,
                                                  product_id: @product.id)
  end

  def set_replenishment
    @replenishment = Replenishment.find(params[:id])
  end

  def save_uploads
    return unless params[:replenishment][:uploads_attributes]

    params[:replenishment][:uploads_attributes].each do |_key, value|
      @upload = Upload.find_by(id: value[:id])
      @upload&.update!(replenishment_id: @replenishment.id)
    end
  end

  def replenishment_params
    params.require(:replenishment).permit(Replenishment::WHITELIST_ATTRIBUTES)
  end

  def sanitize_params
    params[:replenishment][:created_by_id] = current_user.id
    return unless params[:replenishment][:replenishment_line_items_attributes].present?

    params[:replenishment][:replenishment_line_items_attributes].each do |_key, value|
      value[:quantity_after] = value[:quantity_before].to_i + value[:quantity].to_i
    end
  end

  def set_breadcrumb
    add_breadcrumb 'Requisition'.to_s, send("#{params['controller']}_path")
    add_current_action_breadcrumb(params)
  end
end

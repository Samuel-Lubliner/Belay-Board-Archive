class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]

  def accept
    @request = Request.find(params[:id])
    @request.accepted!
    redirect_to availability_requests_path(@request.availability), notice: 'Request accepted.'
  end

  def reject
    @request = Request.find(params[:id])
    @request.rejected!
    redirect_to availability_requests_path(@request.availability), notice: 'Request rejected.'
  end

  # GET /requests or /requests.json
  def index
    @user = current_user
    @requests = Request.joins(:availability).where(availabilities: { user_id: @user.id })
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @availability = Availability.find(params[:availability_id]) if params[:availability_id]
    @request = Request.new(availability: @availability)
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = current_user.sent_requests.new(request_params)
    @request.status = :pending

    respond_to do |format|
      if @request.save
        format.html { redirect_to request_url(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:status, :availability_id)
    end
end

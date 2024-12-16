class SecretsController < ApplicationController
  # before_action :authenticate_user!, exept: [:index, :show] #how to not break the tests?
  before_action :set_secret, only: %i[ show edit update destroy ]


  def map_data
    @secrets = Secret.all
    render json: @secrets
  end

  # GET /secrets or /secrets.json
  def index
    # @show_header = true
    @secrets = Secret.all
  end

  # GET /secrets/1 or /secrets/1.json
  def show
    @permission = if user_signed_in? && @secret.user_id == current_user.id
    @comments = @secret.comments
    end
  end

  # GET /secrets/new
  def new
    # @show_header = true
    @secret = Secret.new
  end

  # GET /secrets/1/edit
  def edit
  end

  # POST /secrets or /secrets.json
  def create
    @secret = Secret.new(secret_params)
    @secret.user_id = current_user.id
    respond_to do |format|
      if @secret.save
        format.html { redirect_to @secret, notice: "Secret was successfully created." }
        format.json { render :show, status: :created, location: @secret }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secrets/1 or /secrets/1.json
  def update
    respond_to do |format|
      if @secret.update(secret_params)
        format.html { redirect_to @secret, notice: "Secret was successfully updated." }
        format.json { render :show, status: :ok, location: @secret }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secrets/1 or /secrets/1.json
  def destroy
    @secret.destroy!

    respond_to do |format|
      format.html { redirect_to secrets_path, status: :see_other, notice: "Secret was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret
      @secret = Secret.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secret_params
      params.require(:secret).permit(:name, :image, :body, :latitude, :longitude, :address)
    end
end

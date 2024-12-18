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
    @secret = Secret.new
    @secret.secret_tags.build # Builds tags for the form
  end

  def create
    @secret = current_user.secrets.new(secret_params)

    if params[:secret][:tag_names]
      params[:secret][:tag_names].each do |tag_name|
        @secret.secret_tags.build(name: tag_name) if SecretTag::VALID_TAGS.include?(tag_name)
      end
    end

    if @secret.save
      redirect_to @secret, notice: 'Secret was successfully created.'
    else
      render :new
    end
  end



  def edit
  end

  def update
    if @secret.update(secret_params)
      redirect_to @secret, notice: 'Secret was successfully updated.'
    else
      render :edit
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


  private

  def secret_params
    params.require(:secret).permit(:name, :description, :image, :latitude, :longitude, :address)
  end
end

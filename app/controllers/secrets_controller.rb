class SecretsController < ApplicationController
  # before_action :authenticate_user!, exept: [:index, :show] #how to not break the tests?
  before_action :set_secret, only: %i[ show edit update destroy ]



    def map_data
      @secrets = Secret.all
      render json: @secrets
    end



  # GET /secrets or /secrets.json
  def index
    @secrets = Secret.all
    Rails.logger.debug "DEBUG: secrets in the database : #{@secrets.inspect}"
  end

  # GET /secrets/1 or /secrets/1.json
  def show
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # GET /secrets/1/edit
  def edit
  end

# POST /secrets or /secrets.json

def create
  # Initialize a new secret
  @secret = Secret.new(secret_params)
  @secret.user = current_user # Associate the secret with the new user

  # Save the secret
  respond_to do |format|
    if @secret.save
      format.html { redirect_to @secret, notice: "Secret was successfully created with a new user." }
      format.json { render :show, status: :created, location: @secret }
    else
      puts "Failed to save secret: #{@secret.errors.full_messages}" # Debugging
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

    def secret_params
      params.require(:secret).permit(:name, :description, :latitude, :longitude)
    end
end

class AdventuresController < ApplicationController
  before_action :set_adventure, only: %i[ show edit update destroy ]

  # GET /adventures or /adventures.json
  def index
    @adventures = Adventure.all
  end

  # GET /adventures/1 or /adventures/1.json
  def show
  end

  # GET /adventures/new
  def new
    @adventure = Adventure.new
  end

  # GET /adventures/1/edit
  def edit
  end

  # POST /adventures or /adventures.json
  def create
    @adventure = Adventure.new(adventure_params)

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to @adventure, notice: "Adventure was successfully created." }
        format.json { render :show, status: :created, location: @adventure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adventures/1 or /adventures/1.json
  def update
    respond_to do |format|
      if @adventure.update(adventure_params)
        format.html { redirect_to @adventure, notice: "Adventure was successfully updated." }
        format.json { render :show, status: :ok, location: @adventure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1 or /adventures/1.json
  def destroy
    @adventure.destroy!

    respond_to do |format|
      format.html { redirect_to adventures_path, status: :see_other, notice: "Adventure was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventure
      @adventure = Adventure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adventure_params
      params.require(:adventure).permit(:naam, :beschrijving, :likes, :amountOfSecrets)
    end
end

class SecretTagsController < ApplicationController
  before_action :set_secret_tag, only: [:destroy]


  def index
    @secret_tags = SecretTag.all
  end


  def new
    @secret_tag = SecretTag.new
  end


  def create
    @secret_tag = SecretTag.new(secret_tag_params)
    if @secret_tag.save
      redirect_to secret_tags_path, notice: 'Tag created.'
    else
      render :new
    end
  end

  # Destroy a tag
  def destroy
    @secret_tag.destroy
    redirect_to secret_tags_path, notice: 'Tag deleted.'
  end

  private

  def set_secret_tag
    @secret_tag = SecretTag.find(params[:id])
  end

  def secret_tag_params
    params.require(:secret_tag).permit(:name, :secret_id)
  end
end

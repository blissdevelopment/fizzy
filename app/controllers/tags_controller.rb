class TagsController < ApplicationController
  include BucketScoped

  before_action :set_bubble, only: %i[ new create ]

  def index
    @tags = Current.account.tags.order(:title)
  end

  def new
  end

  def create
    @bubble.tags << Current.account.tags.find_or_create_by!(tag_params)
    redirect_to bucket_bubble_url(@bucket, @bubble)
  end

  def destroy
    Current.account.tags.find(params[:id]).destroy
    redirect_to bucket_tags_url(@bucket)
  end

  private
    def tag_params
      params.require(:tag).permit(:title)
    end

    def set_bubble
      @bubble = @bucket.bubbles.find(params[:bubble_id])
    end
end

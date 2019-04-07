class Api::ConcertTagsController < ApiController
  before_action :load_tags
  def index
    render partial: 'concerts/concert_tags', layout: false, locals: {concert: @concert}
  end

  def create
    @tags.find_or_create_by! tag_params
    load_tags
    index
  end

  def destroy
    @tags.find(params[:id]).destroy!
  end

  private

  def index_data
    {
      composers: @tags.to_a.select(&:composer),
      pieces: @tags.to_a.select(&:piece),
      performers: @tags.to_a.select(&:performer)
    }
  end

  def tag_params
    params.require(:concert_tag).permit(:composer_id, :piece_id, :performer_id)
  end

  def load_tags
    @concert = Concert.find(params[:concert_id])
    authorize! :edit, @concert
    @tags = @concert.concert_tags.preload(:composer, :piece, :performer)
  end
end

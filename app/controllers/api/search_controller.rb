class Api::SearchController < ApiController
  def composers
    render json: model_data(Ohmymusic::Composer)
  end

  def pieces
    render json: model_data(Ohmymusic::Piece)
  end

  def performers
    render json: model_data(Ohmymusic::Performer)
  end

  def index
    render json: {
      composers: model_data(Ohmymusic::Composer),
      pieces: model_data(Ohmymusic::Pieces),
      performers: model_data(Ohmymusic::Performer)
    }
  end

  private

  def model_data(model)
    model.search(params[:q], page: params[:page] || 1, per_page: params[:per_page] || 10)
  end
end

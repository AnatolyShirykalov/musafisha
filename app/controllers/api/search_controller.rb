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

  def halls
    render json: model_data(Hall, match: :word_start)
  end

  def index
    render json: {
      composers: model_data(Ohmymusic::Composer),
      pieces: model_data(Ohmymusic::Pieces),
      performers: model_data(Ohmymusic::Performer)
    }
  end

  private

  def model_data(model, options = {} )
    model.search(params[:q], {
      page: params[:page] || 1,
      per_page: params[:per_page] || 10,
    }).merge(options)
  end
end

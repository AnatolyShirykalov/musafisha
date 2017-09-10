class AudiosController < ApplicationController
  def create
    audio = Audio.create audio_params
    unless audio.persisted?
      flash[:errors] = audio.errors.messages.map do |k, v|
        "#{k} #{v}"
      end.join("\n")
    end
    redirect_to request.env['HTTP_REFERER']
  end

  private
  def audio_params
    params.require(:audio).permit(:audio, :concert_id)
  end
end

module ApplicationHelper
  def next_prev model
    return {} if params[:action] != 'show'
    {'data-next' => url_for(model.next),
     'data-previous' => url_for(model.previous),
     'class' => 'nextprev'}
  end

  def decided visit
    return "" if visit.nil?
    "#{visit.user.name} утверждает «" +
      t("activerecord.attributes.visit.aasm_state.#{visit.aasm_state}") + '»'
  end


  def share_url visit
    "http://#{request.domain}/decisions/#{visit.id}"
  end

  def share_vk url
    "https://vk.com/share.php?url=#{url}"
  end
end

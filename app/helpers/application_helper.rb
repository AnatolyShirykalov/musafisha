module ApplicationHelper
  def next_prev model
    return {} if params[:action] != 'show'
    {'data-next' => url_for(model.next),
     'data-previous' => url_for(model.previous),
     'class' => 'nextprev'}
  end

  def decided visit
    return "" if visit.nil?
    "#{visit.user.name} утверждает " +
      t("activerecord.attributes.visit.aasm_state.#{visit.aasm_state}")
  end


  def share_url visit
    url_for(controller: 'decisions', visit: visit, host: request.host)
  end

  def share_vk visit
    "https://vk.com/share.php?url=#{share_url visit}"
  end
end

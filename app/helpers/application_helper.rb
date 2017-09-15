module ApplicationHelper
  def main_nav_classes
    {
      "nav mx-auto d-none d-md-flex" => "nav-item px-4",
      "nav d-block d-md-none" => "nav-item text-center border py-3"
    }
  end

  def visit_nav_classes
    {
      "nav d-block d-md-none" => "nav-item border text-center my-2 ml-5"
    }
  end

  def page_opts page
    case page.fullpath
    when rails_admin_path
      {data: no_turbolinks}
    when destroy_user_session_path
      {data: {method: 'delete'}}
    else
      {}
    end.merge class: 'nav-link'
  end

  def no_turbolinks
    {no_turbolinks: true, turbolinks: false}
  end

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

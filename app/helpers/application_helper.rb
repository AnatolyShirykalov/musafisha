module ApplicationHelper
  def next_prev model
    return {} if params[:action] != "show"
    {"data-next" => "#{url_for(model.next)}", "data-previous" => "#{url_for(model.previous)}", "class" => "nextprev"}
  end
end

module ApplicationHelper
  def format_url(url)
    url.start_with?("http://") ? url : "http://#{url}"
  end

  def format_timestamp(ts)
    ts.strftime("%m/%d/%Y %l:%M%P")
  end
end

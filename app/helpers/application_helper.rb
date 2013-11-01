module ApplicationHelper
  def format_url(url)
    url.start_with?("http://") ? url : "http://#{url}"
  end

  def format_timestamp(ts)
    if logged_in? && !current_user.timezone.blank?
      ts = ts.in_time_zone(current_user.timezone)
    end

    ts.strftime("%m/%d/%Y %l:%M%P %Z")
  end

end

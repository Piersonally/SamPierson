module ApplicationHelper

  def site_title_helper
    'SamPierson' + (Rails.env == 'production' ? '' : " #{Rails.env}")
  end

  def page_heading_helper
    if content_for? :heading
      content_for :heading
    elsif @heading == false
      # Suppress heading
    else
      heading = @heading || title || 'MISSING HEADING, SET title OR content_for :heading'
      content_tag :h1, heading
    end
  end
end

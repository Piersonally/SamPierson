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

  def tick_helper(bool)
    bool ? "\u2713" : ''
  end

  def navbar_random_image_helper
    images = %w[beams chair corridor painted-desert-1 trees wall]
    image = images.sample
    content_tag :style do
      %(nav.navbar { background-image: url("/assets/#{image}.jpg"); }).html_safe
    end
  end
end

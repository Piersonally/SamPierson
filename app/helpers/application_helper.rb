module ApplicationHelper

  def site_title_helper
    'SamPierson' + (Rails.env == 'production' ? '' : (' ' + Rails.env))
  end
end

module Screenshooter

  SCREENSHOTS_FOLDER = Rails.root.join('tmp', 'test_artifacts', 'screenshots')

  def self.clear_screenshots
    FileUtils.rm_rf SCREENSHOTS_FOLDER
    FileUtils.mkdir_p SCREENSHOTS_FOLDER
  end

  def take_screenshot(filename)
    return if ENV['CIRCLECI']
    filename += '.png' unless filename =~ /^\.png$/
    filename_with_index_prefix = '%03d_%s' % [screenshot_index, filename]
    screenshot_path = "#{SCREENSHOTS_FOLDER}/#{filename_with_index_prefix}"
    page.save_screenshot screenshot_path
  end

  def screenshot_index
    $screenshot_index ||= 0
    $screenshot_index += 1
  end
end

RSpec.configure do |config|
  config.include Screenshooter, type: :feature
  config.before(:suite) { Screenshooter.clear_screenshots }
end
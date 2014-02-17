if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xcodeproj_utils'

def fixture_path(path)
  File.join(File.dirname(__FILE__), "fixtures", path)
end

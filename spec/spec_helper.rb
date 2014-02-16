$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xcodeproj_utils'

require 'coveralls'
Coveralls.wear!

def fixture_path(path)
  File.join(File.dirname(__FILE__), "fixtures", path)
end

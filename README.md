# XcodeprojUtils
[![Build Status](https://travis-ci.org/taichino/xcodeproj_utils.png?branch=master)](https://travis-ci.org/taichino/xcodeproj_utils)
[![Coverage Status](https://coveralls.io/repos/taichino/xcodeproj_utils/badge.png?branch=master)](https://coveralls.io/r/taichino/xcodeproj_utils?branch=master)

Util commands for xcode project. Following commands are supported for now.

- Count source lines of files in xcode project
- Show source / resource files in xcode project

## Installation

Add this line to your application's Gemfile:

    gem 'xcodeproj_utils'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xcodeproj_utils

## Usage

	$ xcp_utils lines <PATH_TO_XCODE_PROJECT> <TARGET_NAME>
	$ xcp_utils lines --header_only <PATH_TO_XCODE_PROJECT> <TARGET_NAME>
	$ xcp_utils lines --source_only <PATH_TO_XCODE_PROJECT> <TARGET_NAME>

## License

XcodeprojUtils is available under the MIT license. See the LICENSE file for more info.

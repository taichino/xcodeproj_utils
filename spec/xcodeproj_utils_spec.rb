require 'spec_helper'

describe XcodeprojUtils do
  it 'should have a version number' do
    XcodeprojUtils::VERSION.should_not be_nil
  end

  describe XcodeprojUtils::Project do
    it "raise RuntimeError for a non-existing project" do
      expect { XcodeprojUtils::Project.new('Non-existing.xcodeproj', 'Target1') }.to raise_error(RuntimeError)
    end

    it "raise ArgumentError for a non-existing target" do
      expect { XcodeprojUtils::Project.new(fixture_path('RSpecTest/RSpecTest.xcodeproj'),
                                           'Non-Existing Target') }.to raise_error(ArgumentError)
    end
  end
  
end

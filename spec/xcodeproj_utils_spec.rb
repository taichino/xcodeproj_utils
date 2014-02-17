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

    it "return total lines of source code" do
      proj = XcodeprojUtils::Project.new(fixture_path('RSpecTest/RSpecTest.xcodeproj'), 'RSpecTest')
      total = proj.wc
      header = proj.wc(true)
      source = proj.wc(false, true)
      expect(total).to eq(header + source)
    end
  end
  
end

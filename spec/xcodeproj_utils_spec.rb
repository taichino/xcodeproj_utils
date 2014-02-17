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

    it "lists all source/resource files" do
      require 'stringio'
      
      proj = XcodeprojUtils::Project.new(fixture_path('RSpecTest/RSpecTest.xcodeproj'), 'RSpecTest')
      orig_stdout = $stdout
      capture_stdout = StringIO.new
      $stdout = capture_stdout
      proj.show('source')
      $stdout = orig_stdout
      capture_stdout.rewind()
      lines = capture_stdout.readlines()
      expect(lines.length).to eq(3)

      capture_stdout = StringIO.new
      $stdout = capture_stdout
      proj.show('resource', true)
      capture_stdout.close_write()
      $stdout = orig_stdout
      capture_stdout.rewind()
      lines = capture_stdout.readlines()
      expect(lines.length).to eq(1)
    end
  end
  
end

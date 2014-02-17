require "xcodeproj_utils/version"
require "Xcodeproj"

module XcodeprojUtils
  class Project
    def initialize(proj_name, target_name)
      @proj = Xcodeproj::Project::open(proj_name)
      @target = @proj.targets.select {|target| target.name == target_name}
      raise ArgumentError, "#{target_name} is not found in #{proj_name}" if @target.empty?
      @target = @target.first
    end

    def wc(header_only=false, source_only=false)
      all = !(header_only || source_only) # default is all
      count_source = lambda do
        sources = []
        for file in @target.source_build_phase.files_references
          if file.last_known_file_type and file.last_known_file_type.include? "sourcecode"
            sources.push("'#{file.real_path}'")
          end
        end
        file_params = sources.join(' ')
        source_total = %x{wc -l #{file_params}}
        return source_total.lines[-1].split.first.to_i
      end

      count_header = lambda do
        headers = []
        for file in @proj.files
          if file.path.end_with? ".h"
            headers.push("'#{file.real_path}'")
          end
        end
        file_params = headers.join(' ')
        header_total = %x{wc -l #{file_params}}
        return header_total.lines[-1].split.first.to_i
      end

      source_total = header_total = 0
      source_total = count_source.call if all or source_only
      header_total = count_header.call if all or header_only
      source_total + header_total
    end

    def show(kind, fullpath=false)
      if kind == 'resource'
        files = @target.resources_build_phase.files_references
      elsif kind == 'source'
        files = @target.source_build_phase.files_references
      end

      if files
        for file in files
          next if file.class != Xcodeproj::Project::Object::PBXFileReference
          
          if fullpath
            puts file.real_path
          else
            puts file.path
          end
        end
      end
      return nil
    end
  end
end

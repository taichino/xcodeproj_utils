require "xcodeproj_utils/version"
require "Xcodeproj"

module XcodeprojUtils
  def self.wc(proj_name, target_name, header_only=false, source_only=false)
    proj = Xcodeproj::Project::open(proj_name)

    for t in proj.targets
      next if t.name != target_name
      target = t
      break
    end

    if not target
      abort("#{target_name} is not found in #{proj_name}")
    end

    all = !(header_only || source_only) # default is all
    count_source = lambda do
      sources = []
      for file in target.source_build_phase.files_references
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
      for file in proj.files
        if file.path.end_with? ".h"
          headers.push("'#{file.real_path}'")
        end
      end
      file_params = headers.join(' ')
      header_total = %x{wc -l #{file_params}}
      return header_total.lines[-1].split.first.to_i
    end

    puts all, source_only, header_only
    source_total = header_total = 0
    source_total = count_source.call if all or source_only
    header_total = count_header.call if all or header_only
    source_total + header_total
  end
end

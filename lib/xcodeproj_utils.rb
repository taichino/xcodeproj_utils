require "xcodeproj_utils/version"
require "Xcodeproj"

module XcodeprojUtils
  def self.wc(proj_name, target_name)
    proj = Xcodeproj::Project::open(proj_name)

    for t in proj.targets
      next if t.name != target_name
      target = t
      break
    end

    if not target
      abort("#{target_name} is not found in #{proj_name}")
    end

    sources = []
    for file in target.source_build_phase.files_references
      if file.last_known_file_type and file.last_known_file_type.include? "sourcecode"
        sources.push("'#{file.real_path}'")
      end
    end
    file_params = sources.join(' ')
    source_total = %x{wc -l #{file_params}}
    source_total = source_total.lines[-1].split.first.to_i

    headers = []
    for file in proj.files
      if file.path.end_with? ".h"
        headers.push("'#{file.real_path}'")
      end
    end
    file_params = headers.join(' ')
    header_total = %x{wc -l #{file_params}}
    header_total = header_total.lines[-1].split.first.to_i

    source_total + header_total
  end
end

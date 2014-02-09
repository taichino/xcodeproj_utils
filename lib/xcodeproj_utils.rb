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

    files = target.source_build_phase.files_references
    source_total = 0
    for file in files
      if file.last_known_file_type and file.last_known_file_type.include? "sourcecode"
        source_total += %x{wc -l \"#{file.real_path}\"}.split.first.to_i
      end
    end

    header_total = 0
    for file in proj.files
      if file.path.end_with? ".h"
        header_total += %x{wc -l \"#{file.real_path}\"}.split.first.to_i
      end
    end

    source_total + header_total
  end
end

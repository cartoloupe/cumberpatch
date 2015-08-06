require 'fileutils'

`rm features/*.feature`
dirs = `find features -type d -not -path "*subdir*" -not -path "*step_def*" -not -path "*support" -not -path "features"`
dirs.split("\n").each do |dir|
  FileUtils.rm_rf dir
end

`rm -rf features/step_definitions/*`
`rm xaa* report-xaa*`

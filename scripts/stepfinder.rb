pattern = /(?:Given|When|Then|And).+\/(.*)\/.+/
pattern2 = /\/(.*)\//

all_the_regexes = []

linenumber = 1
stepfiles = File.join("**", "*steps.rb")
Dir.glob(stepfiles) do |file|
  linenumber = 1
  File.open(file).each do |line|
    if line =~ pattern then
      regexstring = (line.scan pattern2).flatten.first
      regex = Regexp.new(regexstring)
      all_the_regexes << [regex, file, linenumber]
    end
    linenumber += 1
  end
end

all_the_regexes.each do |regexarr|
  if ARGV[0] =~ regexarr.first then
    puts "#{regexarr[1]}:#{regexarr[2]}"
  end
end

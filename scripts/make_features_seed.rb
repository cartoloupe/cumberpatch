require 'securerandom'
require 'pry'
require 'randexp'

def get_random_step
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

  a_regex = all_the_regexes.sample
  "Given #{a_regex.first.gen}"
end

def write_feature_header
  thing = SecureRandom.uuid
  header = <<-HEADER
  Feature: A thing does a #{thing}

  HEADER

  header
end

def write_random_feature
  thing = SecureRandom.uuid
  object = SecureRandom.uuid

  definition = <<-FEATURE
    Scenario: Some thing #{thing} does something else
      #{get_random_step}
      #{get_random_step}
      #{get_random_step}
      #{get_random_step}
      #{get_random_step}

  FEATURE

  definition
end

10.times do
  file_name = SecureRandom.uuid
  file_path = "features/#{file_name}.feature"

  File.open(file_path, 'a') do |f|
    f.puts write_feature_header
    10.times do
      f.puts write_random_feature
    end
  end
  puts file_path
end


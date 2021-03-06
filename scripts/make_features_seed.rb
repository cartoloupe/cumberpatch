require 'securerandom'
require 'pry'
require 'randexp'
require_relative '../lib/words.rb'

class Stepper
  def initialize
    pattern = /(?:Given|When|Then|And|But).+\/(.*)\/.+/
    pattern2 = /\/(.*)\//

    @all_the_regexes ||= []

    linenumber = 1
    stepfiles = File.join("**", "*steps.rb")
    Dir.glob(stepfiles) do |file|
      linenumber = 1
      File.open(file).each do |line|
        if line =~ pattern then
          regexstring = (line.scan pattern2).flatten.first
          regex = Regexp.new(regexstring)
          @all_the_regexes << [regex, file, linenumber]
        end
        linenumber += 1
      end
    end

    @all_the_regexes.reject!{|r| r.to_s =~ /total/}
  end

  def get_random_step
    a_regex = @all_the_regexes.sample
    binding.pry if a_regex.nil?
    "#{a_regex.first.gen}"
  end
end

class Featurer
  def initialize
    @s = Stepper.new
  end

  def write_assertion_step total
    "Then the total should be #{total}"
  end

  def write_feature_header
    header = <<-HEADER
    Feature: A #{random_noun} is #{random_adjective}

    HEADER
  end

  def write_random_feature
    @assertion = 0
    definition = <<-FEATURE
      Scenario: Some #{random_noun} should #{random_verb}
        Given #{@s.get_random_step.tap{|s| @assertion += s.length}}
        #{ rand(1..7).times.map do
"        And #{@s.get_random_step.tap{|s| @assertion += s.length} }"
          end.join("\n")
        }
        When #{@s.get_random_step.tap{|s| @assertion += s.length}}
        #{write_assertion_step @assertion}

    FEATURE
  end
end




@s = Featurer.new
@files ||= []
N_FEATURE_FILES.times do
  file_name = "#{random_adjective}_#{random_noun}".gsub(" ","_")
  file_path = random_file_path "features/"
  file_path = File.join(file_path, "#{file_name}.feature")

  if @files.include? file_name
    nil
  else
    @files << file_name
    File.open(file_path, 'a') do |f|
      f.puts @s.write_feature_header
      FEATURES_PER_FILE.times do
        f.puts @s.write_random_feature
      end
    end
    puts file_path
  end
end

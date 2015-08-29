require 'securerandom'
require 'pry'
require_relative '../lib/words.rb'

class RandomStepper
  def initialize
    @phrases ||= []
  end

  def write_random_step_definition
    sleep_number = rand(0..SLEEP_RANGE) / 10.0
    addend = rand(1..10)
    phrase = "#{random_subject} #{random_verb} the #{random_noun}"
    addend = phrase.length

    if @phrases.include? phrase
      nil
    else
      @phrases << phrase
      definition = <<-STEPDEF
      Given(/#{phrase}/) do
        sleep #{sleep_number}
        @browser.goto '#{random_url}'

        # add #{addend}
        @total.nil? ? @total = #{addend} : @total += #{addend}
      end

      STEPDEF
    end

  end

  def random_url
    %w(
      https://www.google.com/
      http://www.imagemagick.org/
      https://github.com/dodie/cucumber-gifreporter-experiment
      http://spectacleapp.com/
      https://robots.thoughtbot.com/four-phase-test
    ).sample
  end


  def write_assertion_step_definition
    definition = <<-STEPDEF
    Then(/the total should be (\\d{1,99})/) do |total|
      expect(@total).to eq total.to_i
    end

    STEPDEF
  end
end


@s = RandomStepper.new
wasd = rand(1..N_STEP_FILES) - 1
N_STEP_FILES.times do |n|
  file_name = "#{random_verb}_#{random_noun}".gsub(" ","_")
  file_path = random_file_path "features/step_definitions/"
  file_path = File.join(file_path, "#{file_name}_steps.rb")

  File.open(file_path, 'a') do |f|
    if wasd == n
      f.puts @s.write_assertion_step_definition
    end
    N_STEP_DEFINITIONS_PER_FILE.times do
      f.puts @s.write_random_step_definition
    end
  end
  puts file_path
end


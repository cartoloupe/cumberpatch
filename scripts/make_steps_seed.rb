require 'securerandom'
require 'pry'
require_relative '../lib/words.rb'

def write_random_step_definition
  sleep_number = rand(1..10) / 10.0
  addend = rand(1..10)
  phrase = "#{random_subject} #{random_verb} the #{random_noun}"
  addend = phrase.length
  definition = <<-STEPDEF
  Given(/#{phrase}/) do
    sleep #{sleep_number}

    # add #{addend}
    @total.nil? ? @total = #{addend} : @total += #{addend}
  end

  STEPDEF
end

def write_assertion_step_definition
  definition = <<-STEPDEF
  Then(/the total should be (\\d{1,99})/) do |total|
    expect(@total).to eq total.to_i
  end

  STEPDEF
end

NSTEPS = 10
wasd = rand(1..NSTEPS) - 1
NSTEPS.times do |n|
  file_name = "#{random_verb}_#{random_noun}".gsub(" ","_")
  file_path = "features/step_definitions/#{file_name}_steps.rb"

  File.open(file_path, 'a') do |f|
    if wasd == n
      f.puts write_assertion_step_definition
    end
    10.times do
      f.puts write_random_step_definition
    end
  end
  puts file_path
end


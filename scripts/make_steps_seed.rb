require 'securerandom'
require 'pry'
require_relative '../lib/words.rb'

def write_random_step_definition
  object = SecureRandom.uuid
  sleep_number = rand 3
  definition = <<-STEPDEF
  Given(/I verb the #{object}/) do
    sleep #{sleep_number}
  end
  STEPDEF

  definition
end

10.times do
  file_name = SecureRandom.uuid
  file_path = "features/step_definitions/#{file_name}_steps.rb"

  File.open(file_path, 'a') do |f|
    10.times do
      f.puts write_random_step_definition
    end
  end
  puts file_path
end


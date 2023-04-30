require 'openai'
require 'dotenv/load'
require 'json'
require 'fileutils'
require 'open3'
require 'colored'
require 'diffy'

OpenAI.configure do |config|
  config.access_token = File.read('openai_key.txt').strip
end

def send_code_to_gpt(client, script_name,language1,language2)
  file_lines = File.readlines(script_name)
  file_with_lines = file_lines.each_with_index.map { |line, idx| "#{idx + 1}: #{line}" }.join

  initial_prompt_text = File.read('prompt.txt')

  prompt = build_prompt(initial_prompt_text, file_with_lines,language1,language2)

  response = client.chat(
    parameters: { model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: prompt }], temperature: 1.0 }
  )

  output =  response.dig('choices', 0, 'message', 'content').strip
  status = response.dig('object')
  [output, status]
end

def build_prompt(initial_prompt_text, file_with_lines,language1,language2)
  initial_prompt_text +
    "\n\n" \
    "Here is the code that needs to convert from "+language1.to_s+" to "+language2.to_s+":\n\n" \
    "#{file_with_lines}\n\n" \
    'Please provide your suggested changes'
end

def main
  if ARGV.length < 2
    puts 'Usage: trenscoda.rb <file_name> <language1> <language2> ...'
    puts 'Remember that file_name is written in language1'
    exit(1)
    end

    file_name = ARGV[0]
    language1 = ARGV[1]
    language2 = ARGV[2]
    client = OpenAI::Client.new

  loop do
    output, status = send_code_to_gpt(client,file_name,language1,language2)

    if status == 'chat.completion'
      puts 'Script ran successfully.'.blue
      puts "Output: #{output}"
      break
    else
      puts 'Script crashed. Trying to fix...'.blue
      puts "Output: #{output}"
    end
  end
end

main if __FILE__ == $PROGRAM_NAME

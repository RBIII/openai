require 'httparty'
require 'pry'
require 'json'

prompt_text = 'a very cute old cat and a very cute old furry otter playing in the water'
# prompt_text = 'a cyberpunk version of the battle between Morgoth and Fingolfin from J.R.R. Tolkien\'s The Silmarillion, where Fingolfin is an elf with long hair and Morgoth is wielding a large, technologically advanced, hammer.'

# Construct the request payload
payload = {
  prompt: prompt_text,
  model: "dall-e-3",
  n: 1,
  size: "1024x1024"
}

# Make the request to the OpenAI API
response = HTTParty.post("https://api.openai.com/v1/images/generations",
                         headers: {
                           "Content-Type" => "application/json",
                           "Authorization" => "Bearer #{ENV['DALI_E_3_SECRET']}"
                         },
                         body: payload.to_json)

# Check if the request was successful
if response.code == 200
  result = JSON.parse(response.body)
  image_id = result['created']
  image_url = result['data'][0]['url']

  puts "Generated image ID: #{image_id}"
  puts "Generated image URL: #{image_url}"
else
  puts "Error: #{response.code} - #{response.message}"
end
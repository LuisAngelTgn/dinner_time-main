require 'uri'
require 'net/http'

# Define the URI
uri = URI("https://jsonplaceholder.typicode.com/users")


# Make the GET request and store the response
response = Net::HTTP.get(uri)

# Split the response into key-value pairs
users = JSON.parse(response)

# items = response.split(' ')

# Initialize a count
count = 0

# Iterate through the items to count values of "age" equal to or higher than 50
# users.each do |item|
#   key, value = item.split('=')
#   if key == 'username' && value == "Bret"
#     count += 1
#   end
# end

users.each do |user|
  if user["username"] == "Bret"
    count += 1
  end
end

# Output the count
puts "Count of items with age greater than or equal to 50: #{count}"

require 'net/http'
require 'json'
 
url = "https://api.coingecko.com/api/v3/coins/ethereum"
 
uri = URI(url)
response = Net::HTTP.get(uri)
 
data = JSON.parse(response)
 
price = data["market_data"]["current_price"]["usd"]
 
puts("The price of Ethereum is: " + price.to_s + " USD")
 
puts("Please enter an Ethereum address: ")
address = gets.chomp
 
url = "https://api.ethplorer.io/getAddressInfo/" + address + "?apiKey=freekey"
 
uri = URI(url)
response = Net::HTTP.get(uri)
 
data = JSON.parse(response)
 
balance = data["ETH"]["balance"]
 
puts("The balance of Ethereum in that address is: " + balance.to_s + " ETH")
 
total = balance.to_f * price.to_f

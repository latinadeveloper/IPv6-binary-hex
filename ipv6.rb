#variable set to a string of the address in binary

address_binary = "00100000 00000001 00001101 01110100 00111000 00101101 00000000
00010010 00000000 00000000 00000000 00000001 00010010 00110100  10101010 01010110"

# #This string will then be split with the delimiter of a space (“
# split_address = address_binary.split(" ")
# puts "split_address"
# puts split_address.inspect
# puts ""
#
#   #Then each of these elements needs to be split in half creating 4 character strings.
#   ## also { |quad| [quad[0..3],quad[4..7]]  }
# split = split_address.collect do |quad|
#   [quad[0..3],quad[4..7]]
# end
# split = split.flatten
# puts "quad"
# puts split.inspect
# puts ""
#
# #converting to canonical
#
# #binary string to integer
# hex_characters= split.collect do |binary_string|
#   binary_string.to_i(2).to_s(16)
# end
# puts "hex characters"
# puts hex_characters.inspect
# puts ""
#
# #groups by 4 hex characters
# leading = hex_characters.each_slice(4).collect do |group_four|
#   group_four.join
# end
# puts "grouping by 4"
# puts leading.inspect
# puts ""
#
# #delete leading 0s
# no_leading_zeros = leading.collect do |delete_leading|
#   delete_leading.gsub(/^0{1,3}/, "")
# end
# puts "no leading 0s"
# puts no_leading_zeros.join(":").inspect
# puts ""
#
#
# string.split(/\s/).map { |string| [string[0..3], string[4..-1]] }.flatten.map { |string| string.to_i(2).to_s(16) }.each_slice(4).map(&:join).map { |s| /0{0,3}(.+)/.match(s)[1] }.join(':')

###
# split_address = address_binary.split(" ")
#
# split = split_address.collect { |quad| [quad[0..3],quad[4..7]]  }.flatten
#
# hex_characters= split.collect {|binary_string|  binary_string.to_i(2).to_s(16)}
#
# leading = hex_characters.each_slice(4).collect { |group_four| group_four.join }
#
# no_leading_zeros = leading.collect {|delete_leading|  delete_leading.gsub(/^0{1,3}/, "")}.join(":")
# puts no_leading_zeros


no_leading_zeros = address_binary
  .split(" ")
  .collect{ |quad| [quad[0..3],quad[4..7]]  }
  .flatten
  .collect {|binary_string|  binary_string.to_i(2).to_s(16)}
  .each_slice(4).collect { |group_four| group_four.join }
  .collect {|delete_leading|  delete_leading.gsub(/^0{1,3}/, "")}.join(":")

puts no_leading_zeros

require 'pry'

arr = File.read('input.txt').strip.split(',').map &:to_i

record = Hash.new()

arr.each_with_index do |num, index|
  turn = index + 1
  record[num] = turn
end

turn = record.length + 1
pn = arr.last()

while true 
  cn = record[pn] == nil ? 0 : turn - 1 - record[pn]
  record[pn] = turn - 1

  break if turn == 30000000

  pn = cn
  turn += 1
end

puts cn

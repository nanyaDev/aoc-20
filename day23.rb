require 'pry'

input = "942387615"
sample = "389125467"
cups = input.strip.split('').map(&:to_i)
cups = cups + (10..1000000).to_a

arr = Array.new(cups.length+1)

# array/ll ds: i = cup value and arr[i] = next cup
# gives O(1) insertion/deletion and look up
cups.each_with_index do |cup,i|
  if cup == cups.last
    arr[cup] = cups[0]
  else
    arr[cup] = cups[i+1] 
  end
end

cur = cups[0]
n = cups.length
10000000.times do
  # remove 3 cups
  a = arr[cur]
  b = arr[a]
  c = arr[b] 
  arr[cur] = arr[c]

  # find dest cup
  dest = cur
  loop do
    dest -= 1
    next if [a,b,c].include?(dest)
    
    if dest < 1
      dest = n+1
      next
    end

    break
  end

  # insert
  temp = arr[dest]
  arr[dest] = a
  arr[c] = temp 

  # select new cup
  cur = arr[cur]
end

# print
def print_cups(arr, start)
  ret = []
  (arr.length-1).times do
    ret << start
    start = arr[start]
  end 
  p ret[0,20]
end

print_cups(arr,1) 
a = arr[1]
b = arr[a]
puts a*b
exit

# part 1
curr_val = cups[0]
count = 1
1000000.times do
  count += 1
  p count

  curr = cups.find_index(curr_val)
  three_cups = (cups*2)[curr+1,3]
  three_cups.each { |x| cups.delete(x) }

  dest_cup = curr_val
  loop do
    dest_cup -= 1

    break if cups.include?(dest_cup)

    if dest_cup < cups.min
      dest_cup = cups.max
      break
    end 
  end

  dest_index = cups.find_index(dest_cup)
  cups = cups.insert(dest_index + 1, *three_cups)
  curr_index = (cups.find_index(curr_val) + 1) % cups.length
  curr_val = cups[curr_index]

  print "pickup: "
  p three_cups
  print "destination: "
  puts dest_cup
end

p cups
i = cups.find_index(1)
puts (cups[i+1..-1] + cups[0..i-1]).join('')

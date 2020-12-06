input_arr = File.open('input.txt').read.split("\n")

ret = []

[1,3,5,7].each do |right| 
  tree_count = 0

  input_arr.each_with_index do |item, index|
    r_index = (index * right) % 31
    tree_count += 1 if item[r_index] == '#'
  end

  ret.append(tree_count) 
end

tree_count = 0

input_arr.each_with_index do |item, index| 
  r_index = (index * 1) % 31

  if index*2 >= input_arr.length
    break
  end

  if input_arr[index*2][r_index] == '#'
    tree_count += 1
  end 
end

ret.append(tree_count)
ans = ret.reduce(:*)

puts "ret: #{ret}"
puts "answer: #{ans}"


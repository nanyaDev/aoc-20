input_arr = File.readlines('sample.txt').map &:to_i

input_arr.sort!

n_ones = 0
n_threes = 1

input_arr.each_with_index do |item, index|
  diff = input_arr[index] - input_arr[index-1]
  diff = item - 0 if index == 0

  if  diff == 1
    n_ones += 1
  elsif diff == 3
    n_threes += 1
  else
    puts diff
  end 
end

puts n_ones * (n_threes)

input_arr.unshift 0
input_arr.append(input_arr.max + 3)

diff_arr = []

input_arr.each_with_index do |item, index| 
  break if index == input_arr.length - 1

  diff_arr << input_arr[index+1] - item
end

def perms(diff_arr, last_index)
  if last_index == 0
    return [1,0,0] if diff_arr[0] == 1
    return [0,1,0] if diff_arr[0] == 2
    return [0,0,1] if diff_arr[0] == 3
  end

  ret = perms(diff_arr, last_index - 1)

  if diff_arr[last_index] == 3
    return [0, 0, ret.sum]
  elsif diff_arr[last_index] == 2
    return [0, ret.sum, ret[0]]
  elsif diff_arr[last_index] == 1
    return [ret.sum, ret[0], ret[1]] 
  end
end

puts perms(diff_arr, diff_arr.length - 1)


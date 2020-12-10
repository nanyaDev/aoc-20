input_arr = File.open('input.txt').read.split("\n").map &:to_i

n = 25
num = 731031916

input_arr.each_with_index do |item, index|
  next if index < n

  arr = input_arr[index - n, n]

  flag = false
  arr.each do |i|
    if arr.include?(item - i) # edge case with halves?
      flag = true 
      break
    end
  end 

  if flag == false
    puts item 
    break
  end
end

def process (input_arr, num) 
  input_arr.each_with_index do |item, index|
    arr = [item]
    offset = 1

    loop do
      arr << input_arr[index + offset]

      if arr.sum == num
        puts arr.min + arr.max
        return
      end

      break if arr.sum > num

      offset += 1
    end
  end
end

process(input_arr, num)

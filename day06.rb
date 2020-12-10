input_arr = File.open('input.txt').read.split("\n\n")

input_arr.map! do |str|
  str.split("\n")
end

ret = 0

input_arr.each do |arr|
  n = arr.length
  letters = ('a'..'z').to_a
  count_arr = Array.new(26, 0)

  arr.each do |str| 
    str.split('').each do |ltr|
      letters.each_with_index do |a, i|
        count_arr[i] += 1 if ltr == a
      end
    end
  end

  count_arr.each do |elem|
    ret += 1 if elem == n
    test += 1 if elem == n
  end 
end

puts ret

input_arr = File.open('input.txt').read.split("\n")

parsed_arr = []
input_arr.each do |str|
  /(.*) (.*)/ =~ str
  parsed_arr << [$1, $2.to_i] 
end

def test_if_end(arr)
  acc = 0
  i = 0
  visited_i = []

  loop do
    return false if visited_i.include? i
    return acc if i == arr.length

    visited_i << i
    ins = arr[i]
    cmd = ins[0]
    num = ins[1]

    i += 1 if cmd == "nop"
    i += num if cmd == "jmp"
    if cmd == "acc"
      acc += num
      i += 1
    end
  end
end

parsed_arr.each_with_index do |item, index|
  cmd = item[0]
  next if cmd == "acc"

  # awkward way to avoid shallow copy problem
  parsed_arr = []
  input_arr.each do |str|
    /(.*) (.*)/ =~ str
    parsed_arr << [$1, $2.to_i] 
  end

  test_arr = parsed_arr # why does this changed parsed array as well?!

  test_arr[index][0] = "jmp" if cmd == "nop"
  test_arr[index][0] = "nop" if cmd == "jmp"

  ret = test_if_end(test_arr)
  ret == false ? next : print(ret) 
end


input_arr = File.open('input.txt').read.split("\n")

sol = 0

input_arr.each do |str|
  arr = str.split(' ')

  num1 = arr[0].split('-')[0].to_i
  num2 = arr[0].split('-')[1].to_i
  ltr = arr[1][0]
  pwd = arr[2] 
  
  i1 = num1 - 1
  i2 = num2 - 1

  puts "#{pwd[i1]} #{pwd[i2]} #{ltr}"

  if pwd[i1] == ltr && pwd[i2] == ltr
  elsif pwd[i1] == ltr || pwd[i2] == ltr
    sol += 1
  end
    
end

puts sol


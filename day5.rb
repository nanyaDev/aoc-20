input_arr = File.open('input.txt').read.split("\n")

ret = []

input_arr.each do |code|
  r_code = code[0..6]
  c_code = code[7..9]

  r_min = 0
  r_max = 127

  r_code.split('').each do |half|
    diff = r_max - r_min + 1
    if half == 'F'
      r_max -= diff/2
    else
      r_min += diff/2
    end 
  end

  c_min = 0
  c_max = 7

  c_code.split('').each do |half|
    diff = c_max - c_min + 1
    if half == 'L'
      c_max -= diff/2
    else
      c_min += diff/2
    end 
  end 
  ret << r_min * 8 + c_min
end 

IDS = (0..1023).to_a
IDS.each do |id|
  if !ret.include?(id) && ret.include?(id+1) && ret.include?(id-1)
    puts id 
  end
end

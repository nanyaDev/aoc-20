arr = File.open('input.txt').read.split("\n")

ans1 = nil
ans2 = nil
ans3 = nil

arr.map! { |i| i.to_i }

arr.each do |element|
  sum = 2020 - element
  arr.each do |elem|
    opp = sum - elem

    if arr.include?(opp)
      ans1 = elem 
      ans2 = opp
      ans3 = element
    end
  end
end

puts ans1 * ans2 * ans3

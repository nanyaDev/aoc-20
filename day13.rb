input = File.read('input.txt').split
input[1] = input[1].split(',')
input2 = input.flatten[(1..-1)]
input[1].delete("x")
input.flatten!.map! &:to_i

ts = input.shift 
arr = [] 
input.each do |time|
  x = ts % time
  if x == 0 then arr << 0 else arr << time - x end
end

min = arr.min
i = arr.find_index(min)
bus = input[i]

puts min*bus

goal = []
counter = 0
input2.each do |elem| 
  if elem == 'x'
    counter += 1
  else 
    goal << counter
    counter += 1
  end
end
goal.shift

base = input.shift
base_times = 0
n_times = 1
goal_at = []
repeats_at = []

input.each_with_index do |n, i|
  loop do
    diff = n*n_times - base*base_times
    if diff == goal[i]
      goal_at << base_times
      break
    end
    diff < goal[i] ? n_times += 1 : base_times += 1
  end
  base_times = 0
  n_times = 1
end

repeats_at =  input

a = goal_at[0]
b = repeats_at[0]

goal_at.length.times do |i|
  next if i == 0
  n = 0
  loop do
    c = goal_at[i]
    d = repeats_at[i]

    if (a + b*n) % d == c
      a = a + b * n
      b = b.lcm(d)
      break
    else 
      n += 1
    end
  end
end

p a * base

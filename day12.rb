arr = File.read('input.txt').split

arr.map! do |str|
  /(\D)(\d*)/ =~ str
  [$1, $2.to_i]
end

s_ew = 0
s_ns= 0
ew = 10
ns = 1
curr_dir = 0
$DIR = %w[E N W S]

def process(cmd, n, ew, ns, curr_dir)
  case cmd
  when 'E' then ew += n
  when 'W' then ew -= n
  when 'N' then ns += n
  when 'S' then ns -= n
  # part 1
  #when 'L' then curr_dir += n / 90
  #when 'R' then curr_dir -= n / 90
  when 'L' 
    (n/90).times do
      ew, ns = -ns, ew
    end
  when 'R'
    (n/90).times do
      ew, ns = ns, -ew
    end
  end

  return ew, ns, curr_dir
end

arr.each do |cmd, n|
  if cmd == 'F'
    s_ew += ew * n
    s_ns += ns * n 
  else 
    ew, ns, curr_dir = process(cmd, n, ew, ns, curr_dir) 
  end
  puts "waypoint: #{ew}, #{ns} ship: #{s_ew}, #{s_ns}"
end

puts s_ew.abs + s_ns.abs

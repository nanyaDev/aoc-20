require 'pry'

inp = File.read('input.txt').strip.split("\n")

arr = inp.map do |str| 
  ret = []
  until str.empty?
    if str.length == 1
      ret << str[0]
      break
    end

    if str[0] == 'e' || str[0] == 'w'
      ret << str[0]
      str[0] = ''
    else 
      str[1] == 'e' || str[1] == 'w'
      ret << str[0,2]
      str[0,2] = ''
    end
  end 
  ret
end

tiles = []
arr.each do |cmd|
  x = 0
  y = 0

  cmd.each do |s|
    case s
    when 'e' then x += 1
    when 'w' then x -= 1
    when 'se'
      x += 0.5
      y -= 1
    when 'ne'
      x += 0.5
      y += 1
    when 'sw'
      x -= 0.5
      y -= 1
    when 'nw'
      x -= 0.5
      y += 1
    end
  end
  
  if tiles.include?([x,y])
    tiles.delete([x,y])
  else
    tiles << [x,y]
  end
end

offsets = [[-1,0],[1,0],[0.5,1],[0.5,-1],[-0.5,1],[-0.5,-1]]

start = Time.now
tiles = Set.new(tiles) # why does this increase speed so much?
count = 0
100.times do
  count += 1
  x_vals = tiles.collect { |x| x[0] }
  y_vals = tiles.collect { |x| x[1] }
  x_min, x_max = x_vals.min-0.5, x_vals.max+0.5
  y_min, y_max = y_vals.min-1, y_vals.max+1 

  og_tiles = Set.new(tiles.clone)

  white_list = []
  og_tiles.each do |x,y|
    adj_black = 0
    offsets.each do |xo,yo|
      if og_tiles.include?([x+xo,y+yo])
        adj_black += 1 
      else
        white_list << [x+xo,y+yo]
      end
    end
    s = Time.now
    tiles.delete([x,y]) if adj_black == 0 || adj_black > 2
  end 

  white_list.tally.select { |k,v| v == 2 }.each_key do |k|
    tiles << k
  end 
  print "Day #{count}:"
  puts tiles.length
end

print "\n"
finish = Time.now
print "Time: "
puts finish - start
print "Answer: "
puts tiles.length


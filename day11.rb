arr = File.read('input.txt').split("\n").map{ |str| str.split('')} 

$r = arr.length
$c = arr[0].length
ROWS = (0..arr.length - 1).to_a
COLS = (0..arr[0].length- 1).to_a

def print_hash(h)
  arr = Array.new($r) { Array.new($c) }
  h.each do |key, value|
    row = key[0]
    col = key[1]
    arr[row][col] = value
  end

  arr.each do |e|
    puts e.join('')
  end
end

seats = Hash.new()
seats_new = Hash.new()

# convert hash into array
arr.each_with_index do |dummy, row| 
  dummy.each_with_index do |item, col|
    seats[[row,col]] = item
  end
end

def get_adj_i(r,c)
  adj_i = []

  [-1,0,1].each do |dr|
    [-1,0,1].each do |dc|
      next if dr ==  0 && dc == 0
      adj_i << [r+dr, c+dc]
    end
  end

  return adj_i
end 

def get_adj_o_1(seats, adj_i)
  adj_o = 0

  adj_i.each do |i|
    next if seats.key?(i) == false
    adj_o += 1 if seats[i] == '#'
  end 

  return ad_o
end

def get_adj_i_2(r,c, flag = false) 
  adj_i = Array.new(8) { Array.new }
  (1..$r - 1).each do |n|
    i = 0
    [-n, 0, n].each do |dr|
      [-n, 0, n].each do |dc|
        next if dr == 0 && dc == 0
        new_r = r + dr
        new_c = c + dc
        if new_r < 0 || new_c < 0 || new_r >= $r || new_c >= $c
          i += 1
        else
          adj_i[i] << [new_r, new_c]
          i += 1
        end
      end 
    end
  end 

  if flag # testing
    adj_i.each do |arr|
      p arr
      puts "\n"
    end
  end
  return adj_i
end

def get_adj_o_2(seats, adj_i) 
  adj_o = 0

  adj_i.each do |i_list|
    i_list.each do |i| 
      break if seats.key?(i) == false
      break if seats[i] == 'L'
      if seats[i] == '#'
        adj_o += 1
        break
      end
    end
  end

  return adj_o
end

flag = true
while flag
  flag = false
  ROWS.each do |r|
    COLS.each do |c| 
      adj_i = get_adj_i_2(r,c)
      adj_o = get_adj_o_2(seats, adj_i)

      s = seats[[r,c]]
      seats_new[[r,c]] = s
      next if s == '.'
      if s == 'L' && adj_o == 0
        seats_new[[r,c]] = '#' 
        flag = true
      elsif s == '#' && adj_o >= 5
        seats_new[[r,c]] = 'L' 
        flag = true
      end
    end
  end 

  puts "\n"
end

ret = 0
seats.each_value do |value|
  ret += 1 if value == '#'
end

puts ret


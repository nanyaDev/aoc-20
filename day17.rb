require 'pry'

def print_arr(arr)
  zb = arr.length/2
  zi = (-zb..zb).to_a
  arr.each_with_index do |plane, i|
    puts "z = #{zi[i]}"
    plane.each do |row|
      puts row.join('')
    end 
  end
end

def grow_arr(arr)
  w = arr.length
  z = arr[0].length
  y = arr[0][0].length
  x = arr[0][0][0].length

  ret = Array.new(w+2) { Array.new(z + 2) { Array.new(y + 2) { Array.new(x + 2, '.') } } }
  for w in (1..w)
    for z in (1..z)
      for y in (1..y)
        for x in (1..x)
          ret[w][z][y][x] = arr[w-1][z-1][y-1][x-1]
        end
      end
    end
  end
  return ret  
end

# read input
inp = File.read('input.txt').split("\n").map { |x| x.split('') }
sp = [[inp]]
sp = grow_arr(sp) # grow here to avoid offset out of bounds

# offsets for 26 neightbouring elements
a = [-1,0,1]
offset = a.product(a).product(a).product(a).map(&:flatten) - [[0,0,0,0]]

# iterating through cycles
cycles = 6
cycles.times do
  sp = grow_arr(sp); 
  ogsp = Marshal.load( Marshal.dump(sp) ) # deep copying bc idk

  wl = sp.length
  zl = sp[0].length
  yl = sp[0][0].length
  xl = sp[0][0][0].length

  # iterating through space(xyz)
  for w in (1..wl-2)
    for z in (1..zl-2)
      for y in (1..yl-2)
        for x in (1..xl-2)
        
          # iterating through neighbours for each xyz
          adj = 0
          offset.each do |os|
            wo = w + os[0]
            zo = z + os[1]
            yo = y + os[2]
            xo = x + os[3]

            adj += 1 if ogsp[wo][zo][yo][xo] == '#' 
          end

          # updating each xyz
          if ogsp[w][z][y][x] == '#'
            sp[w][z][y][x] = adj == 2 || adj == 3 ? '#' : '.'
          else 
            sp[w][z][y][x] = adj == 3 ? '#' : '.'
          end 

        end
      end
    end
  end

end

puts sp.flatten.count('#')




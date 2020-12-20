require 'pry'

input = File.read('input.txt').split("\n\n").map { |x| x.split("\n") }

$DIR = ['t','r','b','l']
$hash = {}
input.each do |tile|
  title = tile.shift
  /(\d+)/ =~ title
  $hash[$1.to_i] = tile.map { |x| x.split('') }
end

def rotate90(title, hash=$hash)
  hash[title] = hash[title].transpose.map(&:reverse)  
end

def flipx(title, hash=$hash)
  hash[title] = hash[title].map(&:reverse)
end

def flipy(title, hash=$hash)
  hash[title] = hash[title].transpose.map(&:reverse).transpose
end

def find_match(title,dir,hash=$hash)
  top,right,bot,left = get_edges(title)
  to_match = dir == 'r' ? right : bot

  $hash.each_key do |ti|
    next if ti == title
    get_edges(ti).each_with_index do |edge, i|
      if edge == to_match || edge.reverse == to_match
        return ti, $DIR[i]
      end
    end
  end

end

def orient_match(title1,dir1,title2,dir2,hash=$hash)
  dir1_n = $DIR.find_index(dir1)
  target_n = (dir1_n + 2) % 4
  cur_n = $DIR.find_index(dir2)

  rot = (target_n - cur_n) % 4
  rot.times do
    rotate90(title2)
  end 
   
  if get_edges(title1)[dir1_n] != get_edges(title2)[target_n]
    dir1 == 'r' ? flipy(title2) : flipx(title2)
  end
end

def get_edges(title, hash=$hash)
  tile = hash[title]

  top = tile[0]
  bot = tile[-1]
  left = tile.transpose[0]
  right = tile.transpose[-1]

  return [top,right,bot,left].map(&:join)
end

edge_list = $hash.keys.map { |k| get_edges(k) }.flatten
ue = [] 
$hash.each_key do |title| 
  get_edges(title).each do |edge|
    next if edge_list.count(edge) + edge_list.count(edge.reverse) > 1
    ue << edge 
  end 
end

corner_tiles = []
edge_tiles = []
$hash.each_key do |title|
  uniq_count = 0
  get_edges(title).each do |edge|
    uniq_count += 1 if ue.include?(edge) || ue.include?(edge.reverse) 
  end
  corner_tiles << title if uniq_count == 2
  edge_tiles << title if uniq_count == 1
end

is = Math.sqrt(input.length).to_i 
img = Array.new(is) { Array.new(is) } 

def chkuniq(title,ue)
  uniq = [false,false,false,false] 
  get_edges(title).each_with_index do |edge,i|
    uniq[i] = true if ue.include?(edge) || ue.include?(edge.reverse)
  end
  return uniq
end

root = corner_tiles[0]
until chkuniq(root,ue) == [true,false,false,true]
  rotate90(root)
end

$hash[root] = $hash[root].transpose # tranpose for degbugging !!!
img[0][0] = root

img.each_with_index do |row, i|
  row.each_with_index do |e, j|
    next if j == row.length - 1


    if j == 0 && i != img.length-1 
      num,dir = find_match(e,'b')
      img[i+1][j] = num
      orient_match(e,'b',num,dir)
    end

    num,dir = find_match(e,'r')
    img[i][j+1] = num
    orient_match(e,'r',num,dir)
  end
end

def ptile(tile)
  $hash[tile].each do |arr|
    print arr.join
    puts "\n"
  end
end

$hash.each do |title, tile|
  new_tile = tile[1..-2].transpose[1..-2].transpose
  $hash[title] = new_tile 
end

def combine_lr(t1,t2)
  ret = []

  for i in (0..t1.length-1)
    ret << t1[i] + t2[i]
  end
  return ret
end

img.each_with_index do |row,i|
  img[i] = row.map{ |pos| $hash[pos] }
  img[i] = img[i].reduce{ |a,b| combine_lr(a,b) }.map(&:join)
end
img = img.flatten

def rotate(img)
  return img.map { |s| s.split('') }.transpose.map(&:reverse).map(&:join)
end

def flip(img)
  return img.map(&:reverse)
end


a = img
b = rotate(a)
c = rotate(b)
d = rotate(c)
e = flip(img)
f = rotate(e)
g = rotate(f)
h = rotate(g)


options = [a,b,c,d,e,f,g,h]

mon_count = []
options.each_with_index do |img,i|
  pat = /.{18}#.{1}.{76}#.{4}##.{4}##.{4}###.{76}.{1}#.{2}#.{2}#.{2}#.{2}#.{2}#.{3}/ # doesn't find all bc scan doesn't find overlaps
  pat = /(?=(.{18}#.{1}.{76}#.{4}##.{4}##.{4}###.{76}.{1}#.{2}#.{2}#.{2}#.{2}#.{2}#.{3}))/

  count = img.join.scan(pat).size 
  if count > 0
    mon_count << count
    puts img.join
  end
end 

mon_count = mon_count.max

puts img[0].length - 20
puts mon_count
rough = img.join.count('#') - mon_count * 15
puts rough


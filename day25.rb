key1, key2 = File.read('input.txt').strip.split("\n").map(&:to_i)

def get_ls(sn,target)
  ls = 0 
  val = 1
  loop do
    ls += 1
    val *= sn
    val %= 20201227 
    break if val == target 
  end 
  return ls 
end

ls1 = get_ls(7,key1)
ls2 = get_ls(7,key2)

sn = key1
ls = 0
val = 1
loop do
  ls += 1
  val *= sn
  val %= 20201227 
  break if ls == ls2
end 

p val



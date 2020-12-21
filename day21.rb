arr = File.read('input.txt').split("\n")

foods_i = []
foods_a = []

arr.each do |food| 
  if food.include? "("
    /(.+) \(contains (.+)\)/ =~ food
    foods_i << $1.split(' ')
    foods_a << $2.split(', ')
  else
    foods_i << food.split(' ')
    foods_a << nil
  end 
end

hash = Hash.new(Array.new)

for i in (0..foods_i.length-1)
  food_i = foods_i[i]
  food_a = foods_a[i]

  food_a.each do |all|
    hash[all] += food_i
  end
end

ing_hash = Hash.new(0)

foods_i.each do |ing_list|
  ing_list.each do |ing|
    ing_hash[ing] += 1
  end
end

hash.each do |all, ings|
  ret = []
  mode = ings.tally.values.max
  
  ings.uniq.each do |ing|
    next if ings.count(ing) < mode 
    ret << ing
  end

  hash[all] = ret
end

det_alls = []
det_ings = []

until hash.empty? 
  hash.each do |all,ings|
    if ings.length == 1
      det_alls << all
      det_ings << ings[0]
    end
  end

  hash.each do |all,ings|
    ret = []
    ings.each do |ing|
      next if det_ings.include?(ing)
      ret << ing
    end 
    if ret.empty?
      hash.delete(all)
    else
      hash[all] = ret
    end 
  end
end

acc = 0
ing_hash.each do |ing,count|
  next if det_ings.include?(ing)
  acc += count
end

# p acc

det_pairs = [] 
for i in (0..det_ings.length-1)
  det_pairs << [det_ings[i],det_alls[i]]
end

det_pairs.sort_by! { |x| x[1] }
ret = []
det_pairs.each do |tuple|
  ret << tuple[0]
end

p ret.join(',')


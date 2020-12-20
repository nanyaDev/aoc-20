require 'pry'
require 'set'

rules, msgs = File.read('input.txt').split("\n\n").map { |x| x.split("\n") }

ors = Array.new(rules.length)

rules.each do |str|
  /(\d+): (.*)/ =~ str
  ors[$1.to_i] = $2
end

def recurse(ors, i) 

  rule = ors[i]
  isltr = rule.match? /"."/
  isor = rule.match? /.*\|.*/
  
  return [rule[1]] if isltr
  
  if isor
    ret = []

    rule.split("|").each do |s1|
      c1 = s1.scan(/\d+/).map(&:to_i).map { |x| recurse(ors,x) }.reduce do |a,b|
        a.product(b).map &:join
      end 
      ret << c1 
    end
    return ret.flatten
  else
    return recurse(ors, rule.to_i) unless rule.include?(" ")
    return rule.scan(/\d+/).map(&:to_i).map { |x| recurse(ors,x) }.reduce do |a,b| 
      a.product(b).map &:join
    end
  end 
  return ret.flatten
end

valid = recurse(ors,0)
valid8 = recurse(ors,8)
valid42 = recurse(ors,42)
valid31 = recurse(ors,31)

count = 0
msgs.each do |msg|
  if valid.include?(msg)
    count += 1
    puts msg
    next
  end

if msg.length % 8 == 0
    msg_arr = msg.split('').each_slice(8).map(&:join)
    next unless valid8.include?(msg_arr[0])
    # need ending condition too

    i = 0
    count8 = 0
    count31 = 0
    while i < msg_arr.length
      if valid8.include?(msg_arr[i]) 
        count8+=1
        i += 1
      else 
        break
      end
    end 

    while true
      if valid31.include?(msg_arr[i])
        count31 += 1
        i += 1
      else
        break
      end
    end 
    if count31 > 0 && count8 > count31 && count8 + count31 == msg_arr.length
      count += 1
      puts msg
    end
  end
end

puts count



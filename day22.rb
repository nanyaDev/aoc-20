p1, p2 = File.read('input.txt').split("\n\n").map { |x| x.split("\n").drop(1).map(&:to_i) }

def play(p1,p2,flag=false)
  round = 1
  states = [] 
  while true 
    if p2.empty? || states.include?([p1,p2])
      return 1
    elsif p1.empty?
      return 2
    else
      states << [p1.clone,p2.clone] 
    end 

    winner = 0
    if p1.length > p1[0] && p2.length > p2[0]
      winner = play(p1.clone[1,p1[0]],p2.clone[1,p2[0]])
    else
      winner = p1[0] > p2[0] ? 1 : 2
    end

    if winner == 1
      p1 << p1.shift << p2.shift
    else
      p2 << p2.shift << p1.shift
    end 
  
    if flag
      round += 1
      puts "round ##{round}"
      # print "p1: "
      # p p1
      # print "p2: "
      # p p2 
    end
  end
end

def get_score(arr)
  ret = 0
  arr.reverse.each_with_index do |card, i|
    ret += card * (i + 1)
  end 
  return ret
end

winner = play(p1,p2,true) 
puts winner == 1 ? get_score(p1) : get_score(p2)


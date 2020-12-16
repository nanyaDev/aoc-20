rules, yt, nt = File.read('input.txt').split("\n\n").map { |x| x.split("\n") }

r = []
rules.each do |rule|
  /\w+: (\d+)-(\d+) or (\d+)-(\d+)/ =~ rule
  r << [$1,$2,$3,$4].map(&:to_i)
end

yt = yt[1].split(",").map &:to_i
nt = nt.drop(1).map{ |s| s.split(",").map &:to_i }


invalid_tickets = []
invalid = []
nt.each_with_index do |ticket, i|
  ticket.each do |v|
    flag = false
    r.each do |rule|
      r1l, r1u, r2l, r2u = rule

      if (v >= r1l && v <= r1u) || (v >= r2l && v <= r2u)
        flag = true
        break
      end 
    end
    if flag == false
      invalid << v
      invalid_tickets << i
    end
  end 
end

invalid_tickets.uniq!

ot = []
nt.each_with_index do |ticket, i|
  ot << ticket unless invalid_tickets.include?(i)
end

fields = Array.new(r.length) { Array.new() }
(0..r.length-1).to_a.each do |fn|
  ot.each do |tic|
    fields[fn] << tic[fn]
  end 
end

r_to_f = Array.new(r.length) { Array.new() }

r.each_with_index do |rule, rule_i|
  r1l, r1u, r2l, r2u = rule
  fields.each_with_index do |field, field_i| 
    flag = true
    field.each do |v|
      unless (v >= r1l && v <= r1u) || (v >= r2l && v <= r2u)
        flag = false
        break
      end
    end
    r_to_f[rule_i] << field_i if flag
  end
end

r_to_f.length.times do 
  ones = []
  r_to_f.each do |item|
    if item.length == 1
      ones << item[0]
    end 
  end
  # p ones
  ones.each do |one|
    r_to_f.each do |item|
      unless item.length == 1
        if item.include? one
          item.delete(one)
        end
      end
    end
  end
end

yt_real = []
r_to_f.flatten.each do |fi|
  yt_real << yt[fi]
end

p yt_real[0,6].reduce(:*)

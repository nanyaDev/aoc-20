arr = File.read('input.txt').split("\n").map { |e| e.split(' = ') }

arr.map! do |sa|
  if sa[0] == "mask"
    sa
  else
    /mem\[(\d+)\]/ =~ sa[0]
    # [$1, sa[1].to_i.to_s(2).rjust(36,'0')]
    [$1.to_i.to_s(2).rjust(36,'0'), sa[1]]
  end
end

def permute_mask(mask)
  ba = []

  n = mask.count("X") 
  n.times do
    ba << 0
    ba << 1
  end

  perms = ba.combination(n).to_a.uniq.map(&:join).sort
end

mask = nil
perms = nil
# mem = []
mem = {}

arr.each do |cmd, value|
  if cmd == "mask"
    mask = value
    perms = permute_mask(value)
  else
    # s = value.chars.map.with_index do |char, i|
    #   mask[i] == "X" ? char : mask[i]
    # end

    # num = s.join('').to_i(2)
    # mem[cmd.to_i] = num
    perms.each do |perm|
      perm = perm.split('')
      add = cmd.clone

      add = add.chars.map.with_index do |char, i|
        case mask[i]
        when "0" then char
        when "1" then "1"
        when "X" then perm.shift
        end
      end

      add = add.join('').to_i(2) 
      mem[add] = value.to_i
    end
  end
end

puts mem.values.sum


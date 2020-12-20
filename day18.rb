require 'pry'

arr = File.read('input.txt').split("\n").map { |str| str.gsub(/\s+/,"") }

def match_paren(str, index)
  sub_str = str[index..-1]
  stack = []

  sub_str.each_char.with_index do |c, i|
    stack << c if c == '('
    stack.pop if c == ')' 

    return i if stack.empty?
  end
end

def match_paren_back(str, index)
  sub_str = str[0..index].reverse
  stack = []

  sub_str.each_char.with_index do |c, i|
    stack << c if c == ')'
    stack.pop if c == '(' 

    return i if stack.empty?
  end
end

def process_string(str)
  ret = 0
  add = true
  i = 0

  while i < str.length
    case str[i]
    when '('
      len = match_paren(str, i) 
      val = process_string(str[i+1,len-1])
      add ? ret += val : ret *= val
      i += len
    when '+'
      add = true
    when '*'
      add = false
    else
      val = str[i].to_i
      add ? ret += val : ret *= val
    end

    i += 1
  end

  return ret
end

def add_brackets(str)
  i = 1
  while i < str.length - 1
    if str[i] != '+'
      i += 1
      next
    end

    ni = i + 1
    ni += match_paren(str,ni) if str[ni] == '('
    str.insert(ni+1,')')

    pi = i - 1
    pi -= match_paren_back(str,pi) if str[pi] == ')'
    str.insert(pi,'(')

    i += 2
  end 
  return str
end

puts arr.map{ |s| process_string(s) }.sum
arr.map!{ |s| add_brackets(s) }
puts arr.map{ |s| process_string(s) }.sum



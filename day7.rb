input_arr = File.open('input.txt').read.split("\n")

bag_objects = {}
bag_names_arr = []
bag_numbers_arr = []

class Bag
  attr_accessor :children, :parents, :number

  def initialize(children, number)
    @parents = []
    if children[0] == 'no other'
      @children = []
      @number = []
    else
      @children = children
      @number = number
    end
  end
end

input_arr.each do |rule_str|
  rule_str.delete! ','
  rule_str.delete! '.'
  bag_names = rule_str.scan(/(\w* \w*) bag/)
  bag_numbers = rule_str.scan(/\d/) # new

  arr = []
  bag_names.each do |sub_arr|
    arr << sub_arr[0]
  end

  bag_names_arr << arr

  arr = [] # new
  bag_numbers.each do |sub_arr|
    arr << sub_arr[0]
  end

  bag_numbers_arr << arr
end

bag_names_arr.each_with_index do |bag_list, index|
  first_bag = bag_list[0]
  bag_objects[first_bag] = Bag.new(bag_list.drop(1), bag_numbers_arr[index])
end

bag_objects.each do |name, object|
  object.children.each do |str|
    bag_objects[str].parents << name
  end
end

ret1 = bag_objects['shiny gold'].parents

flag = false
until flag
  flag = true
  ret1.each do |bag|
    bag_objects[bag].parents.each do |paren|
      next if ret1.include?(paren)

      ret1 << paren
      flag = false
    end
  end
end

puts ret1.length

ret2 = 0
bag_arr = ['shiny gold']

loop do
  break if bag_arr.empty?

  temp = []

  bag_arr.each do |bag_name|
    bag = bag_objects[bag_name]
    puts bag.number.class
    ret2 += bag.number.map(&:to_i).sum unless bag.number.empty?

    bag.children.each_with_index do |child, index|
      bag.number[index].to_i.times { temp << child }
    end

    bag_arr = temp
  end
end

puts ret2

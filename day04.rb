input_arr = File.open('input.txt').read.split("\n\n") 


ret = 0


input_arr.delete_if do |item|
  flag = true;

  ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'].each do |field|
    flag = false unless item.include?(field)
  end

  !flag
end

input_arr.map! { |e| e.split /[\n\s]+/ }

input_arr.delete_if do |entry|
  flag = false
  entry.each do |field| 
    if field.include? 'byr'
      byr = field.match(/:(.*)/)[1].to_i
      unless byr >= 1920 && byr <= 2002
        flag = true
        break
      end
    end 

    if field.include? 'iyr'
      iyr = field.match(/:(.*)/)[1].to_i
      unless iyr >= 2010 && iyr <= 2020
        flag = true
        break
      end
    end 

    if field.include? 'eyr'
      eyr = field.match(/:(.*)/)[1].to_i
      unless eyr >= 2020 && eyr <= 2030
        flag = true
        break
      end 
    end 

    if field.include? 'hgt'
      hgt = field.match(/:(.*)/)[1]
        if hgt.include? 'cm'
          num = hgt.scan(/\d/).join('').to_i
          unless num >= 150 && num <= 193
            flag = true
            break
          end
        elsif hgt.include? 'in'
          num = hgt.scan(/\d/).join('').to_i
          unless num >= 59 && num <= 76
            flag = true
            break
          end
        else
          flag = true
          break
        end
    end 

    if field.include? 'hcl'
      hcl = field.match(/:(.*)/)[1]
      unless hcl[0] =='#' && hcl.length == 7
        flag = true
        break
      end
      hcl.slice(1,6).split('').each do |ltr|
        array = [*('a'..'f'), *('0'..'9')]
        unless array.include? ltr
          flag = true
          break
        end
      end
    end 
    
    if field.include? 'ecl'
      ecl = field.match(/:(.*)/)[1]
      unless ['amb','blu','brn','gry','grn','hzl','oth'].include? ecl
        flag = true
        break
      end
    end 

    if field.include? 'pid'
      pid = field.match(/:(.*)/)[1]
      pid_nums = pid.scan(/\d/).join('')
      unless pid.length == 9 && pid_nums.length == 9
        flag = true
        break
      end
    end 
  end

  flag
end

print input_arr.length

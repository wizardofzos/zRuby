class Array
  def perm(n = size)
    if size < n or n < 0
    elsif n == 0
      yield([])
    else
      self[1..-1].perm(n - 1) do |x|
	(0...n).each do |i|
	  yield(x[0...i] + [first] + x[i..-1])
	end
      end
      self[1..-1].perm(n) do |x|
	yield(x)
      end
    end
  end
end


require 'pp'



council = Hash.new
council = {"PvdA" => 20,
           "CDA" => 25,
           "VVD" => 20,
           "SP" => 10,
           "GL" => 15,
           "CU" => 8,
           "D66" => 20,
	   "PVV" => 25,
	   "TON" => 2,
           "PvdD" => 3,
           "SGP" => 2 
           }

seats = 0
council.each{|p,pseats| seats += pseats}
minCSize    = (seats / 2) + 1           


parties           = Array.new
council.each_key { |party| parties.push(party)}


coalitions        = Array.new

for i in 1..5
  parties.perm(i) { |x| coalitions.push(x.sort) }
end

unique_coalitions = coalitions.uniq

puts unique_coalitions.count.to_s + " possible coalitions with max. 5 parties"

def coalitionValue(c,council)
  value = 0
  c.each{|p| value += council[p]}
  return value
end

valid_coalitions  = Array.new

unique_coalitions.each{|c| if coalitionValue(c,council) > minCSize then
                              valid_coalitions.push(c)
                              end
                              }

puts valid_coalitions.count.to_s + " are a majority (min. " + minCSize.to_s + ")"

def printit(c,council)
  res = ""
  c.each{|p| res += p + "\t"}
  puts res + coalitionValue(c,council).to_s  
end

valid_coalitions.each {|c| printit(c,council)}


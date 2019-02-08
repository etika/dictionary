require 'date'
require 'benchmark'

class Dictionary
  def combinations(digits)
    #return if number not valid 1
    return [] if digits.nil? || digits.length != 10 || digits.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0
    #number to letters mapping
    letters_hash = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}

    # Read dictionary file and hold all values in a array
    dictionary = {}
    for i in (1..30)
      dictionary[i] = []
    end

    text=File.open('../dictionary/dictionary.txt').read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      dictionary[line.length] << line.chop.to_s.downcase
    end

    keys = digits.chars.map{|digit|letters_hash[digit]}

    results = {}
    total_number = keys.length - 1 # total numbers
    #Loo through all letters and get matching records with dictionary
    for i in (1..total_number - 2)
      first_array = keys[0..i]
      next if first_array.length < 2
      second_array = keys[i + 1..total_number]
      next if second_array.length < 2
      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays #get_combination(first_array, dictionary)#
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      results[i] = [(first_combination & dictionary[i+2]), (second_combination & dictionary[total_number - i +1])] # get common values from arrays
    end
    #arrange words like we need as a output
    final_words = []
    results.each do |key, combinations|
      next if combinations.first.nil? || combinations.last.nil?
      combinations.first.product(combinations.last).each do |combo_words|
        final_words << combo_words
      end
    end
    # for all numbers
    final_words << (keys.shift.product(*keys).map(&:join) & dictionary[11]).join(", ")
    final_words
  end
end
n = 50000
Benchmark.bm do |x|
 x.report("Execution Time for combinations :"){  Dictionary.new().combinations("6686787825") }
end
final_words=Dictionary.new().combinations("6686787825")
print final_words

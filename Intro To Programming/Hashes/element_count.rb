# Write a method element_count that takes in an array
# and returns a hash representing the count of each element in the array.

def element_count(arr)

    newHash = Hash.new(0)

    for i in 0...arr.length do
        newHash[arr[i]] += 1
    end

    return newHash

end

puts element_count(["a", "b", "a", "a", "b"]) #=> {"a"=>3, "b"=>2}
puts element_count(["red", "red", "blue", "green"]) #=> {"red"=>2, "blue"=>1, "green"=>1}
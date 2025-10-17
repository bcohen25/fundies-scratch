include math
include statistics
sample-list = [list: 1, 2, 3]
sample-list
max(sample-list)
min(sample-list)
mean(sample-list)
sum(sample-list)

fun x-all-nums(nums :: List<Number>) -> Number block:
  doc: "Multiplies all numbers in a list and returns the result"
  var result = 1
  for each(n from nums):
    result := result * n
  end
  result
end
    
x-all-nums(sample-list)
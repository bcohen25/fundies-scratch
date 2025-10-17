use context starter2024
include math
include statistics
sample-list = [list: 1, 2, 3, 4]
discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]
unique-discount-code=distinct(discount-codes)
upper-codes=map(string-to-upper, unique-discount-code)
upper-codes.length()
responses=[list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]
distinct-resp=distinct(responses)
lower-resp=map(string-to-lower, distinct-resp)
filtered-resp=filter(lam(n :: String): not(n == "maybe") end, lower-resp)
filtered-resp
fun x-all-nums(nums :: List<Number>) -> Number block:
  doc: "Multiplies all numbers in a list and returns the result"
  var result = 1
  for each(n from nums):
    result := result * n
  end
  result
end

fun sum-evens(nums :: List<Number>) -> Number block:
  var result = 0
  for each(n from nums):
    when (num-modulo(n, 2) == 0):
      result := result + n
    end
  end
  result
end
sum-evens(sample-list)

fun my-length(list1 :: List) -> Number:
  list1.length()
where:
  my-length([list: 1, 3, 9, 10]) is 4
  my-length([list: "hello", "world"]) is 2
end

fun my-doubles(list1 :: List<Number>) -> List<Number> block:
  var new-list = empty
  for each(n from list1):
    doubled = [list: n * 2]
    new-list := new-list.append(doubled)
  end
  new-list
where:
  my-doubles([list: 1, 3, 9, 10]) is [list: 2, 6, 18, 20]
end

fun my-string-lens(list1 :: List<String>) -> List<Number> block:
  var new-list= empty
  for each(n from list1):
    length1= [list: string-length(n)]
    new-list := new-list.append(length1)
  end
  new-list
where:
  my-string-lens([list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]) is [list: 3, 2, 5, 3, 2, 5]
end

fun my-alternating(list1 :: List) block:
  var count = 0
  var new-list = empty
  for each(n from list1) block:
    when (num-modulo(count, 2) == 0):
      new-list := new-list.append([list: n])
    end
    count := count + 1
  end
  new-list
where:
  my-alternating([list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]) is [list: "yes", "maybe", "no"]
end
  
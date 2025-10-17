use context starter2024

check:
  [list:        ] is empty
  [list: 1      ] is link(1, empty)
  [list: 1, 2   ] is link(1, link(2, empty))
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 7,8,9]) is 3
  my-len([list: ]) is 0
  my-len(empty) is 0
end

mylist=[list: 2, 4, 8, 11, 8]
fun find-max(l):
  cases (List) l:
    | empty => -99999
    | link(f, r ) => num-max(f, find-max(r))
  end
where:
  find-max(mylist) is 11
  find-max(empty) is -99999
end

fun string-concat(l :: List) -> String:
  cases (List) l:
    | empty => ""
    | link(f, r) => f + string-concat(r)
  end
where:
  string-concat([list: "a","b","c"]) is "abc"
  string-concat(empty) is ""
end

fun string-upper(l :: List<String>) -> List:
  cases (List) l:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), string-upper(r))
  end
where:
  string-upper([list: "HeLlO World"]) is [list: "HELLO WORLD"]
  string-upper(empty) is empty
  string-upper([list: "h", "i"]) is [list: "H", "I"]
end

fun round-numbers(l :: List<Number>) -> List:
 cases (List) l:
   | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where:
  round-numbers(empty) is empty
  round-numbers([list: 1.3, 2.6, 7]) is [list: 1, 3, 7]
end

(* fun is_older(date1: (int * int * int) list, date2: (int * int * int) list) =  *)
(* date type (int * int * int) list *)
(* date start with year * month * day *)
(* a year have 365 day, feb always have 28 days  *)

fun sum_list(xs: int list) = 
    if null xs
    then 0
    else hd(xs) + sum_list(tl(xs));


(* EX1: 1 is_old, 2 dates, date1 < date *)

fun is_older(date1: int * int * int, date2: int * int * int) =
    if #1 date1 < #1 date2 then true
    else if #1 date1 = #1 date2 then
        if #2 date1 < #2 date2 then true
        else if #2 date1 = #2 date2 then #3 date1 < #3 date2
        else false
    else false;

fun dateToStr(d: int*int*int) =
    "(" ^ Int.toString(#1 d) ^ "," ^ Int.toString(#2 d) ^ "," ^ Int.toString(#3 d) ^ ")";

fun printIsOld(dates: (int*int*int) list) =
    let
        val date1 = hd dates
        val date2 = hd (tl dates)
        val result = is_older(date1, date2)
    in
        print(dateToStr date1 ^ " is older than " ^ dateToStr date2 ^ ": " ^ Bool.toString result ^ "\n")
    end;

printIsOld([(04, 11, 1995), (05, 11, 1995)]);


(* Ex2 *)
fun number_in_month(dates: (int * int * int) list, month: int): int =
    if null dates
    then 0
    else
        if(#2 (hd dates) = month)
        then 1 + number_in_month(tl(dates), month)
        else  number_in_month(tl(dates), month);
 
 number_in_month([(04, 10, 1995), (05, 11, 1995)], 11);

 (* Ex3: 
    problem: 
    Inputs: 
        - dates: (int * int * int) list
        - months: int list

    Output: int (dates are in months)

    Cases
        - Base case: dừng lại khi months null
        - gọi hàm với dates và tl months
            - trong mỗi lần gọi, gọi hàm number_in_month
                với input là: dates và current month
    
  *)
fun number_in_months(dates: (int * int * int) list, months: int list): int =
    if null months
    then 0
    else
        number_in_month(dates, hd(months)) + number_in_months(dates, tl(months))


 val test = number_in_months([(04, 10, 1995), (05, 11, 1995), (05, 9, 1995), (05, 11, 1995)], [11,10]);



(* Ex4: 
    dates_in_month
    Input: 
        - dates: int * int * int list
        - month: int
    Output
        - list of dates are in the month
        - follow the original order from the dates argument
    Case
        - Base case ( when the function stop): dates is empty => []
        - If current date's month = month => include it, recurse on tl
        - If not => skip it, recurse on tl 
 *)
fun dates_in_month(dates: (int * int * int) list, month: int): (int * int * int) list =
    if null dates
        then []
    else 
        if(#2 (hd dates) = month)
            then hd dates :: dates_in_month(tl dates, month)
        else 
            dates_in_month(tl dates, month);

   
val test = dates_in_month([(04, 10, 1995), (05, 11, 1995), (05, 9, 1995), (8, 11, 1995)], 11);


(* Ex5:
NOTE: to add list to list => APPEND @, :: puts single item to list
    Input:
        - dates: list 
        - month: int list, distinct value
    Output: 
        - dates list => dates have month in months list
    Case: 
        - Base: months is empty
        - Recursive months
            - dates_in_month(dates, month) <- all dates matching current month
            - with test_dates_in_months(dates, tl months) <- all dates matching remaining months

*)
fun dates_in_months(dates: (int * int * int) list, months: int list): (int * int * int) list =
    if null months
        then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);


val test_dates_in_months = 
    dates_in_months([(04, 10, 1995), (05, 11, 1995), (05, 9, 1995), (8, 11, 1995)], [11, 9, 6]);


(* EX6
    Input: string list, int
    Output: string 
    Case
        - base: index 1
        - current count = int => return string
        - Recursive: index != 0 -> get_nth(tl strings, index-1)
 *)

 fun get_nth(strings: string list, index: int): string= 
    if index = 1
        then hd strings
    else get_nth(tl strings, index - 1);
val test_get_nth = get_nth(["a","b","c"], 2)


(* EX7
    Input 
        - date
    Output
        - string of the form January 20, 2013
    Case: 
        - Base: month of the get_nth (get_month = 0)
 *)
 fun date_to_string(date: int * int * int): string= 
    let 
        val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        val string_month = get_nth(months, #2 date)
    in 
        (* string_month *)
       string_month ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

    end;
val test_date_to_string = date_to_string((2013, 1, 20))

(* Ex8
    number_before_reaching_sum
    Input:
        - int (sum, positive)
        - int list (positive)
    Output: 
        - int: n, where sum first n items < sum. first n + 1 item >= sum
    Case: 
        - Base: int list empty
        - Recursive int list
            - each loop: sum - hd list
            - if sum - item > 0 => call 1 + number_before_reaching_sum(sum - item, tl())
            - if sum - item < = 0 => return 0 => stop 

 *)

 fun number_before_reaching_sum(sum: int, intList: int list): int = 
    let 
        val cur = hd intList
        val sub = sum - cur
    in
        if(sub > 0) 
            then 1 + number_before_reaching_sum(sub, tl intList)
        else 
            0
    end;

val test_number_before_reaching_sum = number_before_reaching_sum(10, [11,3, 9,5,9]);


(* Ex9
    what_month
    Input: 
        - day: Int (1 - 365)
    Output: 
        - month the day in ()
    Case:
        - Base: day < = 0
        - Recursive: day > 0, input: day, 
 *)

 fun what_month(day: int)= 
    let
        val months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
    (* todo: check *)
       1+ number_before_reaching_sum(day, months) 
    end;

val test_what_month = what_month(60);


(* Ex10
month_range
Input: 
    - day1: date
    - day2: date
Output: 
    - int list: empty if day1 > day2, length day2 - day1 + 1?
 *)
fun month_range(day1: int, day2: int): int list =
    if day1 > day2
        then []
    else
        what_month(day1)::month_range(day1 + 1, day2)
   

val test_month_range = month_range(55, 65);


(* EX11
oldest
    Input: 
    - dates list: (int*int*int) list 
    Output: 
    - NONE if no dates (length = 0)
    - SOME d if the date d is the oldest in the list
 *)

 fun oldest(dates: (int*int*int)list) = 
 (* validate null value *)
    if null dates
    then NONE
    else  
    let
        fun oldest_nonempty(dates: (int*int*int)list) = 
        (* validate empty [] *)
        (* null here is a function checking if list is empty *)
        if null (tl dates) 
        then hd dates
        else 
            let 
                val first = hd dates
                val second = hd (tl dates)
            in 
                if is_older(first, second)
                then oldest_nonempty(first::tl (tl dates))
                else  oldest_nonempty(tl dates)
            end
    in 
        SOME (oldest_nonempty(dates))
    end;


val test_oldest = oldest [(1995,11,4), (2025,12,6)];

(* Ex12, 13
 *)

fun contains (n: int, xs: int list) =
    if null xs
    then false
    else if hd xs = n
    then true
    else contains (n, tl xs)


fun remove_duplicates (nums: int list) =
    if null nums
    then []
    else
        if contains (hd nums, tl nums)
        then remove_duplicates (tl nums)
        else hd nums :: remove_duplicates (tl nums)


fun number_in_months_challenge
    (dates: (int * int * int) list, months: int list) =
    number_in_months (dates, remove_duplicates months)


fun dates_in_months_challenge
    (dates: (int * int * int) list, months: int list) =
    dates_in_months (dates, remove_duplicates months)
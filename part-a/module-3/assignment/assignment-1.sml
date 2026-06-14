(* fun is_older(date1: (int * int * int) list, date2: (int * int * int) list) =  *)
(* date type (int * int * int) list *)
(* date start with year * month * day *)
(* a year have 365 day, feb always have 28 days  *)

fun sum_list(xs: int list) = 
    if null xs
    then 0
    else hd(xs) + sum_list(tl(xs));


    (* 1 is_old, 2 dates, date1 < date *)
fun is_old(dates: (int * int * int) list)=
    let 
        val date1 = hd dates
        val date2 = hd (tl(dates))
    in 
        if(#1 date1 < #1 date2) 
        then true
        else if (#1 date1 = #1 date2)
        then 
            if (#2 date1 < #2 date2 ) 
            then true
            else if (#2 date1 = #2 date2)
            then #3 date1 < #3 date2
            else false
        else false
    end;
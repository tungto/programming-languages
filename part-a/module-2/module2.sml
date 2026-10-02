(* binding x to 34 *)
val x = 34; 
(* repl *)
val x = 50;

val y = x + 120;

(* dynamic env: env created when execute code, includes: expression and declaration *)

(* shadow *)

let val x = 1
in 
	(let val x = 2 in x + 1 end) + (let val y = x + 2 in y + 1 end)
end;

(*(let val x = 2 in x + 1 end) => x = 2  *)

(* (let val y = x + 2 in y + 1 end) => x = 1 *)


fun countup_from1 (x:int) = 
	let fun count (from:int) = 
		if from = x 
		then to:: []
		else from :: count(from+1)
	in 
		count (1)
	end;

(* find the max value? 

if xs null => max = 0
if tl xs = null => hd xs   = max? 
if hd xs > bad_max(tl xs => if hd > run to next max value)
if hd xs < bad_max(tl xs) => pass the tl 
*)
(* fun bad_max (xs: int list) =
	if null xs
		then 0
	else if null (tl xs)
		then hd xs
	else if hd xs > bad_max(tl xs)
		then hd xs
	else bad_max(tl xs)




fun good_max (xs: int list) = 
	if null xs
		then 0
	else if if null (tl xs)
		then hd xs
	else
		let 
			val tail_ans = good_max(tl xs)
		in 
			if hd xs > tail_ans
				then hd xs
			else tail_ans
		end; *)


 
 (* better way, will not use recursive but create inner function instead *)

 (* fun better_max2 (xs: int list) = 
	if null xs
		then NONE
	else let
			fun max_nonempty (xs: int list) = 
				if null (tl xs)
					then hd xs
				else let val tl_ans = max_nonempty(xs)
					in 
						if hd xs > tl_ans
							then hd xs
						else tl_ans
						end
		in 
			SOME(max_nonempty xs)
		end *)





3 + 3.14
datatype mytype = TwoInts of int * int
| Str of string 
| Pizza


fun f(x: mytype) =
	case x of	
		Pizza => 3
		| Str s => 8
		| TwoInts (i1, i2) => i1 + i2;


val result = f(Pizza);
val result = f (TwoInts(9, 10))


datatype exp = Constant of int 
             | Negate of exp 
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e =
    case e of
        Constant i => i
      | Negate e2  => ~ (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Multiply(e1,e2) => (eval e1) * (eval e2)


val test = eval (Negate (Constant 2));


val test_exp = Add (Constant 19, Negate (Constant 4))
(* 19 * 4 *)

fun max_constant e =
	let fun max_val (e1, e2) =
		Int.max (max_constant e1, max_constant e2)
	in
		case e of
			Constant i => i
			| Negate e2 => max_constant e2
			| Add (e1, e2) => max_val (e1, e2)
			| Multiply (e1, e2) => max_val (e1, e2)
	end

val nineteen = max_constant test_exp
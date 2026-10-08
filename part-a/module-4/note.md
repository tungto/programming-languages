## Algebraic Data Type (ADT) or Tagged Union / Sum Type



**4 common usages of Sum type**
Representing Success of Failure
```sml
datatype mytype = Twoints of int * int 
				| Str of string
				| Pizza

datatype 'a result = 
	Success of 'a 
	| Error of string

fun safe_divide (x: int, y: int) = 
	if y = 0
	then Error "Division by zero"
	else Success (x div y)


fun print_result res = 	
	case res of
		Success n => "Result is: " ^ Int.toString n
		| Error msg => "Failed: " ^ msg
```


Modeling Real-world "Either/ or" state

```sml
datatype payment_method = 
	Cash 
	| Creditcard of String * int (*Card number * exp year*) 
	| BankTransfer of string   (*bank_code*) 

fun process_fee (pm: payment_method, amount: real) = 
	case pm of 
		Cash => amount
		| CreditCard()
```
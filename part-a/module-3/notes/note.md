### Questions
What is shadowing? 
- variable shadowing is creating new variable with same name as another variable in an outer scope causing new variable hides the original one within its scope


```javascript
let x = 10;
{
let x = 20; // 20, create new variable that shadows the outer x
console.log(x);
}
console.log(x); // 10 as x is bind to 10 in outer scope

```

What is expression? 
What is dynamic env? static env? 

Arbitrary Types
===============
Introduction
------------
Being able to understand type definitions in OCaml is a very important skill. What does it mean when a function `f` has the type `'a -> 'b -> 'c`? There are two useful ways of thinking about it: 1. as a function of one or more arguments which returns a value, or 2. as a function which takes a single argument and returns a function.

### 1. `f` as function of multiple arguments
Imagine `f` has the type `'a -> 'b -> 'c`. We can think of `f` as a function which takes two arguments, of types `'a` and `'b` respectively:

| `'a`    | `->`  | `'b`  | `->`  | `'c`   |
| :----:  | :----: | :----: | :----: | :----: |
| 1st Argument | | 2nd Argument | | Output |

### 2. `f` as a single-argument function with a function as an output
Imagine `f` has the type `'a -> 'b -> 'c`. We can think of `f` as a function which takes a single argument of type `'a`:

| `'a`    | `->`  | `'b -> 'c`   |
| :----:  | :----: | :----: |
| Argument | | Output |

Here the output is a **function**. What is the type of the output function? It takes an input of type `'b` and has an output of type `'c`.

Examples of Function Types
--------------------------
### 1. `'a -> 'a`
**Can we define a function `f` whose type is `'a -> 'a`?**

First, let's think about what the inputs and outputs are for this function. Referencing point 1 above, we can view `f` as taking a single argument of type `'a`, and returning something of type `'a`.

Next, let's think about what `f` will look like. Since it takes a single input, we can write:
`let f x = ...`. That deals with the input. How do we return something of type `'a`? Well, we know that `x` has the type `'a`, so let's just return that!
```ocaml
let f x = x;;
val f : 'a -> 'a
```

### 2. `'a -> 'a -> 'a`
**Can we define a function `f` whose type is `'a -> 'a -> 'a`?**

As stated in the introduction, there are two ways of looking at this:

1. Similarly, we get the same result when defining `f` as a function that takes two variables, as the compiler again cannot assume that `x` and `y` are of the same type:

  ```ocaml
  let f x y = x;;
  val f : 'a -> 'b -> 'a

  let f x y = y;;
  val f : 'a -> 'b -> 'b
  ```
  
  So in order to get the form we want, we have to imply that `x` and `y` have the same type. We can do this in several ways. The most direct is simply to explicitly specify that the types of `x` and `y` are the same:
  
  ```ocaml
  let f (x:'a) (y:'a) = x;;
  val f : 'a -> 'a -> 'a
  
  let g (x:'a) (y:'a) = y;;
  val g : 'a -> 'a -> 'a
  ```
  
  We can also do this in more subtle ways, such as by comparing the variables:

  ```ocaml
  let f x =
    let g y =
      let _ = (x = y) in
      y
    in g;;
  val f : 'a -> 'a -> 'a
  ```

  By comparing `x` and `y`, we are telling OCaml that they are of the same type, which means that the `'b`s turn into `'a`s.

2. `f` takes one argument and returns a function as an output. In this case, `f` will look like this: `let f x = ...`. In `...` we have to return a function with the type `'a -> 'a`. Well, we know from example 1 that we can define a function with the type `'a -> 'a` by writing `let g y = y`. So let's try defining `g` inside `f` and then return `g`!

  ```ocaml
  let f x =
    let g y = y in
    g;;
  val f : 'a -> 'b -> 'b
  ```

  But wait, why does does `f` now have the type `'a -> 'b -> 'b`? Shouldn't it be `'a -> 'a -> 'a`? Here's the thing: there's nothing restricting `x` and `y` to be the same type, so OCaml tells us that `x` will be of type `'a`, and `y` will be of type `'b`, where `'a` and `'b` may or may not be the same.

### 3. `('a -> 'b) -> 'a -> 'b`
**Can we define a function `f` whose type is `('a -> 'b) -> 'a -> 'b`?**
The first argument of `f` has the type `'a -> 'b`, which is a function. The second argument of `f` has the type `'a`, and the output has type `'b`. A concrete example would be where the first argument is a function `int -> bool`, and it returns whether or not an integer is even, and then the second argument is the integer we want to inspect. For example, `f is_even 5` would be false.

Remember that `f` takes two arguments - a function and something else:

```ocaml
let f g x = g x;;
val f : ('a -> 'b) -> 'a -> 'b
```

So why does this work? Well, OCaml knows that we are taking two inputs and returning an output, so the function will have the type `? -> ? -> ?`. But on the right-hand side of `f`, we apply `g` to `x`, which means that `g` is a function which takes an input `'a` and outputs a type `'b`. And OCaml can also infer that `x` is of this type `'a`. The result of `g x` will be of type `'b`, since the output type of `g` is `b`. So the inputs have the types `('a -> 'b)` and `'a`, and the output will have the type of `g x`, which, as we figured out, is `'b`.

### 4. 'a -> ('a -> 'a) -> 'a
```ocaml
let f x g =
  let _ = g x = x in
  x;;
```








--------------------------

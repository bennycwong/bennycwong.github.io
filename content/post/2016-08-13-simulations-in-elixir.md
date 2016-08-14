+++
date = "2016-08-13T11:20:18-07:00"
description = "Solving fivethirtyeight riddler puzzles in code"
title = "Puzzle  |> Simulations in Elixir"
tags = [
  "fivethirtyeight",
  "elixir",
  "mix",
  "learning",
  "open source",
  'programming languages',
]
slug = "riddler-simulations-in-elixir"
draft = false
+++



For the past few months, I have learning the [elixir](http://elixir-lang.org/) programming language. Much has been written about Elixir, so I won't go into too much details about the language itself.

Instead, I want to share my journey learning elixir. The first stage of my programming language learning is writing a lot of code, with little to no self consciousness about writing "bad code". This is in no way the best way to write elixir (probably), but it's the first step to take me from __knowing about__ something to __knowing something__. I plan to revisit these in the future as I learn more through programming more in elixir.


#### The Riddler

The Riddler is a series of puzzles written by the folks at [Five Thirty Eight](https://fivethirtyeight.com/tag/the-riddler/). Every week or so, they publish a new riddle, as well as post answers to the previous week's puzzles.

The riddles/puzzles are statistical of nature. The answer is usually a math formula or some way to express the probability or expected value of it.

I think there are two ways to solve these problems.  

  1. Think about the problem like a statistician and break down the problem in its own smaller components. Solve for the expected value and probability. Finally combine it all together.

  2. Build a simulation and run it a lot of times.

While the first approach is probably the smarter way to go, building simulations is fun. Plus, if the proof is in the pudding. If my simulation is done right, it becomes the test case to __verify the math from the first approach__.


 Below are two simulations I wrote in Elixir to solve the puzzles on [The Riddler at fivethirtyeight](https://fivethirtyeight.com/tag/the-riddler/).



#### Writing Simulations
I often hear this advice: you learn more when you build your own projects, instead of just following along with tutorials. This gives us two advantage: you care more about building it, thus sustaining your __motivation__, and it requires you to do more than just follow steps. __It makes you think.__


I have observed this to be true. However, coming up with what projects to write is hard work. Seriously hard work. People do this as a career (Product Management).

The hard work of trying to figure out what to build is __not necessary when the purpose of the project is to learn a new technologies__. Hard problems are good, but we need to focus on the right problems.

Since my goal at this phase of learning elixir is writing a lot of programs, I needed a problem that is already defined. Riddler puzzles are great because the problem is given to me. I don't have to spend energy trying to figure out __what__ to write. I just need to figure out __how__ to write it.  

Also, I really like brain teasers and puzzles. These kinds of problems are __fun for me__.

In addition, the fine folks at fivethirtyeight also provide modifications to the problem. This gives a chance to try and refactor and change my code. This is a good time to see how well I abstracted the code. Is it easy to change, or did I have to rewrite the code?

My goal here is not to write the best code, develop a product, or anything of the sort. I'm trying to apply the concepts learned from the getting started guides and use them enough so that when I read about these topics, I have an intuitive understanding and context to lean on.

### The Riddles

#### Elevator Button Problem
[Click here to see the Elevator Button riddle on Riddler](https://fivethirtyeight.com/features/can-you-solve-this-elevator-button-puzzle/)  

> In a building’s lobby, some number (N) of people get on an elevator that goes to some number (M) of floors. There may be more people than floors, or more floors than people. Each person is equally likely to choose any floor, independently of one another. When a floor button is pushed, it will light up.

[See simulation code and results](https://github.com/bennycwong/riddler/tree/master/elevator_button)  

```
$ mix elevator.simluate
```
![Elevantor](https://cloud.githubusercontent.com/assets/4430436/17579892/af24cf12-5f4e-11e6-9f19-be9357d70f2c.gif)


#### The Grizzly Bear Problem
[Click here to see the Grizzly Problem on Riddler](https://fivethirtyeight.com/features/should-the-grizzly-bear-eat-the-salmon/)  

> A grizzly bear stands in the shallows of a river during salmon spawning season. Precisely once every hour, a fish swims within its reach. The bear can either catch the fish and eat it, or let it swim past to safety. This grizzly is, as many grizzlies are, persnickety. It’ll only eat fish that are at least as big as every fish it ate before.

> Each fish weighs some amount, randomly and uniformly distributed between 0 and 1 kilogram. (Each fish’s weight is independent of the others, and the skilled bear can tell how much each weighs just by looking at it.) The bear wants to maximize its intake of salmon, as measured in kilograms. Suppose the bear’s fishing expedition is two hours long. Under what circumstances should it eat the first fish within its reach? What if the expedition is three hours long?

[See simulation code and results](https://github.com/bennycwong/riddler/tree/master/grizzly_problem)

```
$ mix grizzly.simluate
```

![mix grizzly.simulate](https://github.com/bennycwong/riddler/raw/master/grizzly_problem/mix_grizzly_simulate.gif)

+++
date = "2016-08-03T19:19:37-07:00"
description = ""
title = "Git Rebase: Getting Started"

tags = [
  "git",
  "rebase",
  "version control"
]

author = "Benny Wong"
menu = "blog"
+++

From my experience teaching newer developers how to use <u>__git__</u> in our workflow at Dollar Shave Club, the <u>__rebase__</u> feature tends to be one of the most confusing.
I remember having a hard time wrapping my head around it for a while.
This is my attempt at explaining what <u>__rebase__</u> is, as I would've liked to have been taught.*

## A. Star Wars illustration (Analogy)

You are playing the (fictional) latest open-world alternate universe Star Wars game.
In this game, there are dozens of worlds to explore, and in each level, you can gather all sorts of loot. You can <u>__save__</u> game at any time.

##### The save feature is git. It's a way to store the history of your game and how you go to where you are. In git, we call these saves <u>commits</u>.

What makes this game open-world is that you can choose which which world (level) to go to in whatever order you want. You can go from Naboo, then to Endor, and then back to Hoth.

##### Being in the open world is like having branches. From one of your saves, you can branch out and beat levels however you want based on a certain previous save.

For example, for the first part of the game, our saves look like this:

    Level 1 (Naboo) -> Level 2 (Coruscant) -> Level 3 (Kashyyyk)

At this point, you saved the games 3 times, and is on game <u>__save #3__</u>.

Next, you decide you want to jump to Level 10, The Death Star.

Midway through the level 10 (The Death Star) level would be a lot easier to drop bombs in this exhaust shaft if you were in an X-Wing Fighter.
In order to get the X-Wing, you need to beat level 7 (Yavin 4).
Getting to this point in the death star was a lot of hard work involving some precise dodging of Tie Fighters that you don't want to do again.

You decide to save the game here.
This is <u>__save #4__</u>.


    Level 3 (Kashyyyk) -> Mid Way Through Level 10 (The Death Star)

We call the above play-through <u>__the feature branch__</u>.

Now, you decide to start at <u>__Save #3__</u> and beat level 6 and 7, where you gain some force powers and an X-Wing:

    Level 3 (Kashyyyk) -> Level 6 (Tatooine) -> Level 7 (Yavin 4)

We call the above play-through <u>__the master branch__</u>.

The game consider these two <u>__branches__</u> completely different play-throughs.

One amazing feature the game developers created was to let you <u>__combine__</u> these branches as if it was one play-through.

There are two strategies to combine the play-throughs: <u>__merge__</u> and <u>__rebase__</u>.


#### 1. Merge

Using this strategy, you would be in <u>__save #4 in the feature branch__</u> and merging in <u>__save #5 in the master branch__</u>. Practically, it's as if you were in the middle of your fight in the Death Star, and then teleported to Level 5 (Tatooine) and Level 6 (Yevin 4), got your force skills and the X-wing, and teleported back into the heat of battle with the Death Star in your new X-wing.

Here's the new history:

    Level 3 (Kashyyyk) -> Mid Way Through Level 10 (The Death Star) -> Level 6 (Tatooine) -> Level 7 (Yavin) -> Merge Save

Notice that there's an extra bit of history at end. In the git world. this is called a merge commit.

In this example, we are merging

    (the master branch) --> (the feature branch)

In the command line, you would do the following
(assuming you are in the feature branch):

    git merge {repo} branch-b  


<br>
#### 2. Rebase

Rebasing, unlike merging, is rewinding to a common point in history, and then applying the history of the target branch, and then applying the history of the current branch.

In our Star Wars example, rebasing <u>__save #4 in the feature branch__</u> with <u>__save #5 in the master branch__</u> is stopping in the middle of the Death Star battle, rewinding time to Level 3 (Kashyyyk), playing through Level 6 and 7, and then going through Level 10 (The Death Star) all the way to the point in <u>__save #4__</u>, as if it was on the same play-through.

To illustrate this, we are doing this:

    Level 3 (Kashyyyk) -> Level 6 (Tatooine) -> Level 7 (Yavin 4) -> Mid Way Through Level 10 (The Death Star)

Note that there is no extra <u>__merge commit__</u>

In the command line, you would do the following
(assuming you are in the feature branch):

    git rebase {repo} branch-b


## B. Rebase vs Merge Visualized (Diagram)

Here's a visual representation of what the game saves.

##### Branches (Play-throughs)

![branch](https://www.atlassian.com/git/images/tutorials/advanced/merging-vs-rebasing/01.svg)
Legend:  
White -- Your history up till  <u>__save #3__</u>.  
Green -- Your progress in level 10 (The Death Star) <u>__save #4__</u>.  
Blue -- Your saved game after beating level 6 (Tatooine) and 7 (Yavin)  <u>__save #5__</u>.  



##### Merge Strategy


![merge](https://www.atlassian.com/git/images/tutorials/advanced/merging-vs-rebasing/02.svg)

##### Rebase Strategy
![rebase](https://www.atlassian.com/git/images/tutorials/advanced/merging-vs-rebasing/03.svg)


## C. Repo To Practice (Example)

For practice, I've created a demo repo for you to play with.  
Check it out here: [git-rebase-practice](https://github.com/bennycwong/git-rebase-practice) on github.

Note: The $ sign is the command prompt

    $ git clone git@github.com:bennycwong/git-rebase-practice.git
    $ cd git-rebase-practice
    $ git checkout master

Next, take a look at the log.

    $ git log --oneline

    1b4583c mid way through level 10
    93077bc level 3 complete
    efcf95f level 2 complete
    ad638fb level 1 complete
    f295f6c intial commit

Now try to merge feature into master and the take a look at the logs

    $ git merge origin/feature
    $ git log --oneline

    facb4e5 Merge branch 'feature'
    4166d41 level 7 complete
    87ef0c0 level 6 complete
    1b4583c mid way through level 10
    93077bc level 3 complete
    efcf95f level 2 complete
    ad638fb level 1 complete
    f295f6c intial commit

Next, reset your branch (don't worry if you don't understand this)

    $ git reset --hard 1b4583c   

And then rebase and the take a look at the logs

    $ git rebase origin/feature
    First, rewinding head to replay your work on top of it...
    Applying: mid way through level 10

    $ git log
    4cea1be mid way through level 10
    4166d41 level 7 complete
    87ef0c0 level 6 complete
    93077bc level 3 complete
    efcf95f level 2 complete
    ad638fb level 1 complete
    f295f6c intial commit

Make sure you run this in your terminal. Notice that the commit SHAs are now complete different than they were in the merge. This is because we are writing new history.

Definitely play around in your own terminal and try merging/rebasing master into the feature branch. If you get to a state that's too broken, you can always delete the repo and try again:

    $ cd ..
    $ rm -rf git-rebase-practice
    $ git clone git@github.com:bennycwong/git-rebase-practice.git


## D. So why is it called rebasing? (Plain English)

Here is a helpful heuristic to remember rebasing means. Think of this as literally re-**base**-ing something. You are changing what your current branch is **based** on.

Another way to put it, rebase is going back in time and changing history according to another timeline before apply my changes in this current timeline.


## E. Learn More (Technical Definition)

If you want to learn more about this topic, Atlassian has a great git tutorial series [here](https://www.atlassian.com/git/tutorials/merging-vs-rebasing/summary).





## *Appendix A: The ADEPT Method

I'm currently learning how to apply the [ADEPT Method](https://betterexplained.com/articles/adept-method/) of teaching.

<center>
  ![ADEPT](https://betterexplained.com/wp-content/uploads/adept/adept-method.png)
</center>


## Appendix B: So what about conflicts?
Conflicts happen whether you merge or rebase. Look for a post in the future that discuss this topic further...

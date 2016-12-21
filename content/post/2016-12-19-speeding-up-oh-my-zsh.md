+++
title = "Speed Up Oh-My-Zsh"
description = "Simple Strategies to Improve Terminal Startup Times"
date = "2016-12-20T22:05:08-08:00"
tags = [
  "tools",
  "zsh",
  "command-line"
]
slug = "speeding-up-oh-my-zsh"
draft = false
+++

I've been using Robby Russell's [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for as long as I remember. It's familiar to me, and it looks nice. I like the __agnoster__ theme. It's one of the first things I install on every computer.

One of the costs of using Oh-my-zsh is that the startup times are slow. That's what everyone says.

So I accepted that fate. Recently, I've been getting more and more frustrated by the slow startup times, so I turned to the internet to see what I can do to make it faster.

### Step 1: Benchmarking Current Performance
First, I figured out how long it took to start a new shell session. The results were not pretty:

```bash
$ /usr/bin/time zsh -i -c exit
3.07 real         1.58 user         1.27 sys
```

Results: 3.07 seconds. That's the time it takes for a new shell to open. Not Good.


### Step 2: Figure Out What Was Slow

The next step is to determine what causes the slowness.

Running zsh with the -xv flag gives us a read out on what's going on.
```bash
$ zsh -xv
```

While the stream of output is going, I noticed that the screen would hang on ___nvm___ and to a lesser extent ___rvm___. Both are very useful since I work in __Javascript__ and __Ruby__ the most.

However, after some thought, I realize I don't use these commands all too often.

### Step 3: Removing the Infrequently Used

The key insight I have at this point is that I don't need ___nvm____ and ___rvm___ all that often. As it turns out, only when I'm going between different projects.
As a result, I decided to not load them on every shell load, but only do it as needed.

In my ___.zshrc___ file, I created two aliases that help me load ___nvm___ and ___rvm___.

```bash
alias loadrvm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
```

After that, I just removed the default configurations for ___nvm___ and ___rvm___.

Here is the result:

```bash
$ /usr/bin/time zsh -i -c exit
0.28 real         0.13 user         0.11 sys
```

After the two minor tweaks, I got zsh to start in just 280 ms:

I say that's a win for a few minutes of work. And I get to keep the configuration I'm familiar with!

Checkout my dotfiles here:  
[zshrc](https://github.com/bennycwong/dotfiles/blob/master/zshrc)  
[dotfiles](https://github.com/bennycwong/dotfiles)

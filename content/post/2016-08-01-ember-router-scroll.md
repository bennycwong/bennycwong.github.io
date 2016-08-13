+++
date = "2016-08-01T22:23:24-08:00"
title = "Introducing ember-router-scroll"
description = "Open sourcing at Dollar Shave Club"

tags = [
  "Ember",
  "Ember add-on",
  "open source",
  "routing",
  "scroll",
  "UX"
]

author = "Benny Wong"
menu = "blog"
slug = "ember-router-scroll"
+++

***
<center>
__Editorial Note:__ I originally wrote this post for the [DSC Engineering Blog](http://engineering.dollarshaveclub.com/introducing-ember-router-scroll/).  Head over to there and check out the original.  While you’re there, have a look at the other articles.
</center>
***


Here at Dollar Shave Club, we rely heavily on open-source technologies.
We chose Ember.js as our front end framework to build our web experience.

By design, Ember maintains scroll position when transitioning between routes.
This makes sense for typical single page applications (SPAs), as SPAs tend to be rendered with nested views.
If a nested view is 1000px down the page, when you enter that nested route, you would want to still be 1000px down the page.

However, our design calls for rendering pages in a non-nested fashion.
The default Ember behavior of maintaining scroll position is no longer the right user experience (UX).

<center>
![Default ember scroll behavior](https://cloud.githubusercontent.com/assets/4430436/17122972/0a1fe454-5295-11e6-937f-f1f5beab9d6b.gif)
</center>

As a result, one of the first pieces of Ember code written here at Dollar Shave Club is a way to scroll the user to the top of the page on route transition.

Unfortunately, this presents a new UX problem.
While scroll-to-top is good UX for entering a new route, a user would expect to maintain scroll position when going back and forward in the browser.

To solve this problem, we created a `scrollMap` to store scroll states on `willTransition`, a hook that gets called whenever a user leaves a route.
In the `didTransition` hook, we check to see if the transition was triggered by a browser history event ([popstate event](https://developer.mozilla.org/en-US/docs/Web/Events/popstate)).
If a popstate is detected, the user is sent to the scroll position in the `scrollMap` instead of the top.

<center>
![ember-router-scroll behavior](https://cloud.githubusercontent.com/assets/4430436/17122970/07c1a3a0-5295-11e6-977f-37eb955d95b1.gif)
</center>

Check it out here: [ember-router-scroll](https://github.com/dollarshaveclub/ember-router-scroll).

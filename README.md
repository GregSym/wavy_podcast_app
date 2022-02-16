# flutter_podcast_app

![test_suite](https://github.com/GregSym/wavy_podcast_app/actions/workflows/main.yml/badge.svg)


I'm taking another stab at a podcasting application built in flutter

<p>
I looked at the flutter team's example podcasting app a while ago while
trying to work out media players in flutter which I've found to be, 
shall we say, not quite so fun as the other bits of the framework
</p>

<p> The solution in here has been to stack together two different media players
so as to avoid learning platform specific notification stuff, because I've had
some issues with the android implementation of some of those. It's probably 
terribly inefficient but to my immense surprise it does *work* which is kinda all
I'm going for. </p>

<p>
Why the Beamer dependency? Well, I'd like access to path variables, and the only way to achieve
that is Nav2.0, which is not a great idea. So I picked the most popular package on pub.dev
for managing Nav2.0 for me.

reference: https://pub.dev/packages/beamer
</p>

# State of development

Currently working on a simple backend using python to update a Cloud Firestore DB, not because I'm overly fond of the solution, it's simply really quick. The goal is to sync stuff like subscriptions and track position to a user. A mock system has been added to the frontend for local subscriptions.

# Other significant TODOs:

* Add more caching (alternatively, roll back to a lighter weight version)
* Add proper testing
* finish frontend subscription stuff
* Add proper platform boilerplate, version numbering, icons, tab labels, etc

# Tested on:
<ol>
<li>    
    Android 11
</li>
<li>
    Web
</li>
<li>
    Windows 10
</li>
</ol>

## Notes:

There is still no notifications solution for Windows in the build

Notification support has also recently got better on just_audio, possibly to the degree that dropping better_player may be viable for targeting mobile (see above diatribe about stacked media players)
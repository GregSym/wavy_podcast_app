# flutter_podcast_app

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

Tested on:
<ul>
<li>
    Web
</li>
<li>    
    Android 11
</li>
</ul>
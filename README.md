This is a game with chains.
This is the first time I fully used classes with GDScript, and I felt it
was incredibly helpful. I was able to include many more objects
with more unique interactions than I thought I'd be able to, all
because of inheritance and classes. In terms of functions and problem solving, I'm 
very proud of the verlet physics engine I created. I had to make it
from scratch, because my original plan for the chain to be made 
out of RigidBodies and PinJoint2D nodes didn't work. Once I made 
the chain a verlet simulation, everything else had to be one as well.
The main resource I used to learn was the in-engine docs. I think 
there may have been I better way to spawn items and powerups than 
hacing them all in one array and picking them randomly, but I'm not sure.
I shoudl also get better at doing GitHub commits. I usually don't 
work with Git in Godot, so it's not part of my usual workflow, and
is a new habit I need to build. Another example of failure is that
I forgot to add delta timing, which is a hassle to add later.
In the future, I'll add more objects and curses. Curses are an idea
I had late in development, so I couldn't do many besides Curse of 
Fragility. I also want to make more interesting levels and hazards.
I ended up only using the hazard class for ice, which i felt was a waste.
I also need a better tutorial.

Verlet integration:
	https://www.youtube.com/watch?v=1qSJSJKo3rc

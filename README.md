**Platformer Adventure**
I built this 2D platformer in Godot 4 as a web-based demo. My main goal was to practice making responsive jump controls and fixing issues with moving objects in a 2D world.



**How It Works**
Movement: Basic run and jump mechanics. I tweaked the gravity and collision boxes until the controls felt snappy instead of floaty.

Platforms: Moving platforms created using Godot's animation tracks. They are hooked into the physics loop so the player doesn't slide off while standing on them.

Web Build: Exported using the Compatibility renderer (OpenGL 3) so it opens fine in chrome or firefox without long load times.

**Tech Stack**
Engine: Godot 4

Code: GDScript

Platform: HTML5 / Web

**Development Notes**
The hardest part was definitely the moving platforms. At first, whenever the platform moved, my character would stay still or jitter around instead of riding along with it.

I figured out that the animation was running on a normal timer instead of syncing up with Godot's physics step. After changing the process mode to physics and adjusting the keyframes, the platform collision finally worked smoothly.
<img width="1106" height="628" alt="image" src="https://github.com/user-attachments/assets/423ed3a7-d1f8-4d79-9057-4a5a6cdd8c86" />

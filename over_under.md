# Allen
Allen was the first robot we ever brought to a competition, and he served us well. He is named for our mascot Allen, who is the monkey responsible for bringing Allen wrenches to the team members. It was a very simple robot which had gone through many designs, as we were learning a lot about VEX parts. We did not go through any tutorials, we simply learned by doing.

{{allen_1.jpg|1.0}}

## Design

### Drivetrain

Allen was built on an all-iron drivetrain, based on the clawbot. It employed two motors to power the basic drive (motors directly to wheels, no gears). Later we had done some testing with using four motors on the drivetrain.

### Intake mechanism
The intake system on Allen was a simple sprocket surrounded with chains that had flaps on them. This worked well enough and we weren't really sure how we could improve on this. It allowed the robot to pull in a triball, continue to possess it, and eject it into a goal.

### Launcher mechanism

The launcher mechanism was the part which took the most time. It also has an unorthodox design. It uses a motor to stretch a rubber band and hold it in the tensioned position, then a pneumatic piston pushes a gear to release the axle from the motor. This causes the tension to release all at once and launch the triball. As you might expect, this design is a bit unreliable, but designs like this really show our creativity when we are short on resources. We did not have flex wheels or fly wheels or 600 RPM motors, and we could not afford anything. You can see the problems here.

We used a design like this because of how the Over Under game worked. The best strategy was to have a robot which repeatedly launches balls in the preload period, and then to push the pile of balls into the goal.

## Problems encountered

### Pneumatics failure
During building and the competition, we had a habit of inflating the pneumatics tank to above its maximum rated pressure to try and fit more air in it. We did not realize that this would lead to a failure of the bike pump valve, such that it would not hold air anymore. So any mechanism involving pneumatics was off the table, such as our triball launcher. We had to change our strategy at this point. 

So we could not launch triballs any more. In the picture is the final robot we had to use when we had no launcher mechanism. Our only option left was to push around other robots (with two motors?) or to just push triballs into the nets. Even that had problems.

Much later, we had solved this problem by sealing the end of the tank with the bike pump valve, and instead using the tubes themselves to connect to the small outlet of the bike pump.

### `JiggleIt` function
As mentioned previously, the triball launcher was unreliable, and often, almost guaranteed, the gears would jam, making it so the piston can't launch the triball. The solution to this was to add a controller binding to repeatedly extend and retract the piston to free the gear. Of course, this would use a bit of air, but we just did not have much else to do. We also switched to using a shorter piston to minimize air usage, as a shorter piston has the same force but a different extension. This is simply because the force of a piston is only determined by the thickness of the tube.

### Stuck on a triball
During one of the games in the competition (Over Under), the robot got stuck on a triball, and was unable to move for the rest of the game. This reflects the fact that we iterated the design a lot on-site, and had no time to test or drive it. Otherwise, such an issue would have been easily detected. This also ties into another design issue which is that the robot's drivetrain was much wider than it was long. This odd geometry is not beneficial at all, worsening the problem of lifting on acceleration.

### Disassembly on the field
This problem is quite simple. We never liked nylock nuts because they are hard to screw on, and hard to remove, slowing the build process. But they are important. Since we were using keps nuts for the drivetrain, they would often fall off. We did not expect this to happen, and it taught us where strength is important on the robot, and how screws and nuts don't behave the way one may expect.

## PROS
`Aseer`

At this time, we were exploring new technologies. I was more experienced in C than Python, so I decided to explore different ways to write robot code. VEX offers native C++ support, but not C support, and there is a lack of documentation about the different methods, instead relying on Intellisense for showing the right methods. PROS offers C support in a simple package. OkapiLib makes writing autonomous code easy, but we never used it.

As I was reading the tutorial, I realized that the C code was wrong, as it was using C++ syntax, so I submitted a pull request to fix it which was accepted.

I'm really thinking about reconsidering PROS in the future. As we become more experienced in the essential parts of robotics in the manual control period, we can then begin to focus on how we can do the autonomous period.

# Allen 2.0
Allen 2.0 was a very interesting experiment, and we learned a lot building it. Designed by Tyler, it implemented the ideas that we would continue to use for future projects.

## Design
Allen 2.0 used six wheels, two 36:1 (red) motors with a tank drive, and a gear ratio to increase torque. It was unusual because it's not normal to use high-torque 36:1 motors for the drivetrain, especially not to gear them down. Tyler argued that this would allow the robot to exert more force on other robots, making it more assertive on the field. Additionally, the robot was entirely made of iron. These properties combined were the reason that we called this robot "The Tank."

### Offensive strategy
As a new team, we understood that we would not be able to effectively design and build competitive subsystems, especially with our shortage of advanced parts like flex wheels and grip mats. We wanted to go for a simpler strategy, like just focusing on putting the triballs in the goals, or even just pushing other robots around. The thinking was that other teams will only gear for speed, while our robot is geared for unusually high torque, preventing the other team from scoring while our allied team will score points.

### Modular/hackable design
Usually when we build drivetrains, it would be difficult to change the gearing on them, taking multiple sessions. However, this robot was different. The outer guard protecting the wheels was held on by nothing but the metal axle collars. It would take just minutes to change the gear ratio and try a new one. 

## What we learned
Ultimately this design was never used for anything. But we took away these points:

  * The point is not speed or torque, but rather balance. A high speed robot is difficult to control, while a high torque robot is sluggish.
  * Acceleration is not particularly important. A robot with twice the top speed and half the torque will reach the same speed as the robot which doesn't, and then continue to speed up.
  * Modularity is very important, especially since we do not yet use CAD for designing robots. This allows for rapid iteration.
  * For quick prototyping, keps nuts (the ones with the built-in washer) are effective because they hold well enough and are easy to add or remove. However, they will definitely fall off, so when the design is finalized, they should be replaced with nylock nuts.

# Allen 2.1

## Design

### Donut picker-upper
This design was possibly the most iterated throughout the project, as this would determine whether the robot could even do anything. The design is based around a chain which goes from the front of the robot to the top of it at the back, where the stake is attached.

{{triangle_grabbing_donut.jpg|0.8}}

#### Hook design
First we started with making hooks out of metal. We tried small ones, long ones, wide ones, using the claw from the old version of the clawbot, those weird plus pieces. None of them worked consistency and it all felt like it was in vain. Either they would get stuck on the stake, or not even pick up a donut. It wasn't useless though. Now we know with reasonable confidence that metal hooks don't work, at least not the ones we tried.

We were also trying different ways to attach the hook, like with a rubber band tensioning system, different size sprockets at the top.

That's when we started fashioning hooks out of polypropylene. These definitely worked, though we did break a few. It must have been the flexibility that made them work effectively.

#### The chain
We added an additional sprocket to tension the chain without just having fewer chain links. This we kept in the final design. Otherwise the chain would either be too tight or too loose.

### Switch from iron to aluminium
The reason that we used iron in the past is because we were concerned that aluminium, though light, would not provide sufficient strength. However, we realized that:

* **Strength is more determined by geometry.**
    
  {{metal_cross_sections.png|1.0}}

  As you can see in this graphic, the shape of the metal beam (whether C, U, L, or straight) is the main factor which determines how strong the metal is. This is intuitively true, and these are sorted by which ones feel like they would be stronger. 

  The reason for this can be seen on the bottom. When you push on a thin sheet of metal, the metal does not need to stretch much to bend. However, when you push a sheet of metal perpendicular to the direction you're pushing it, the end of it has to bend a whole lot more. If you managed to push it, the end would rip and the side you're pushing would buckle. This is much harder than, for example, bending a metal wire. 

  One example of structural properties is the strength of cardboard as compared to construction paper. Both have approximately the same amount of material, but cardboard is harder to bend.

* **The weak points are the fasteners, not the metal.**

  This one means that if such a force is exerted on the robot that it would fail, the screws would fail before the metal. This protects the metal, and means that you do not need strong metal. However, a force that's more likely is one that will bend the metal but not break the screws. Metal is unlikely to bend when the correct geometry is used, though.

* **Pushing around is not a good strategy.**
  
  Having a heavy drivetrain is an overall downside for the robot. The only benefit is the ability to grip the mats better, and to push around other robots. The other team has two robots, though, and in VEX Robotics the best strategy is usually to score as many points as possible. That's why in the meta, descoring is not a common strategy, though it works.

* **Damaging parts is not important.**

  The metal parts may be bent, but they still work, don't they? You can simply bend it back into position so that it can connect to other hardware.

### Pneumatic stake grabber

Of course, we needed a mechanism to grab the stakes, so that we could possess them and put donuts on them. We decided on a design which grabs the stakes by the rim from the bottom, and lifts them up. This was the usual strategy for teams as it puts less friction between the stake and the field mats. 

#### Redesign

After this, we switched to a different design. Now the robot pushes down the stakes to move them around. A pneumatic piston drags the top of the stake around the ground. It pushes it down so that it is angled towards the robot, and so that the hook can put donuts on it.

### Intake mechanism
When trying to pick up the robot, the problem always was that the hook would push the donut away before picking it up. We decided that the solution to this was a roller which forces the donut towards the robot.

{{roller_mechanism_gearing.jpg|0.5}}
{{roller_mechanism_with_donut.jpg|0.5}}

The interesting thing here is that the roller is powered by the same motor as the donut picker-upper. It goes through some gears to step up the speed and through a chain to get it into the right place. We wanted to maintain flexibility in our motor allocation, which is specifically the reason why we chose a four motor drivetrain and a pneumatic stake grabber. We still have three motors left to do whatever we need, like the elevation.

### Removing the intake mechanism
After testing, we realized that the mechanism was actually redundant. Just the axle's presence alone coerces the donuts into the correct position for the elevator. This simplified the design greatly, and worked surprisingly well. The rollers were not even working to move the donut, and the way it was held on means that it could be rendered pointless in field conditions.

## Programming

### Version control
Before, our version control system was downloading the latest version of the project, editing it, and posting it on the list. This worked fine for a while, but became annoying, the process of downloading, opening, saving, and uploading. This was the problem with VEXCode online projects, as they could only be moved around through a format which is not version control friendly.

Our solution was to start using VS Code for projects, which allows us to version control Python code on `git`. There was a bit of a learning curve, but with previous experience in `git`, you realize that for simple projects, you only need a handful of commands for everything (`push`, `pull`, `commit`, `add`), and when something else happens, you can just search up the commands. The `git` capabilities of VS Code streamline this process even more.

### Switch to Python
The switch to Python happened because of the control curve and the version control. Using Python rather than blocks also seemed much more practical, as it is often easier to read than disparate stacks of blocks, and it is much easier to use common mathematical operations needed for the control system. Python code is also much easier to document. We were really using blocks as a temporary solution.

### Control curve
`Aseer`

Usually, the speed of the motors is proportional to the position of the joystick. However, this solution can be improved. For one, when driving on the field, there is no point in having a sort of in-between speed that is highly precise. Instead, you want more control on low speeds, and more control on high speeds. You still want to provide the full space of speeds, so you put a steep slope in between these two regimes. I thought about what function fits this criteria, and I thought of the logistic curve.

The logistic curve is defined by:

$L\left(x\right)=\frac{M}{1+e^{-k\left(x-a\right)}}$.

Given the values $M = 100$, $k = 0.15$, and $a = 50$, we get this graph:

{{logistic_curve_usual.png|0.8}}

There are a few modifications to make. For one, this only works for positive controller values. When moving the joystick backwards, the expected behavior is for the robot to go backwards. So, we can mirror the curve for negative values to replicate this behavior with negative numbers. Also, there is a certain range where the motor produces the most power, around 63%. This is the fastest speed it can go while still using full torque. See the [Motor curve section](#motor-curve).

```python
def get_velocity(val: float, current_speed=100.0) -> float:

    sgn = 1

    if val < 0:
        val = abs(val)
        sgn = -1

    if 0 < val <= 50:
        return sgn * max(logistic(val), 100)

    if 51 <= val <= 75:
        return sgn * (val + 10)

    if 76 <= val <= 100:
        if abs(current_speed) < 55:
            return sgn * 60
        else:
            return sgn * max(logistic(val), 100)
    
    return 0
```

This code is defined over the interval -100, 100. The reason why the `sgn` variable is used to mirror the logistic function around the origin, so there is similar behavior for both going forwards and backwards. Otherwise, any speed less than 0 will evalulate to 0.

The purpose of the `current_speed` variable is to optimize the robot's acceleration, accounting for the slowdown above 63%. 

You might be wondering about the use of type hints in Python, such as `float` and `int`. These are just to assist the IDE in statically analyzing the code. In Python these type hints do nothing. 

Finally, here's the code which sets the speed of the motors:
```python
left_velocity = limit(target_velocity + turn_velocity/1.5) * VEL_PERCENT / 100
right_velocity = limit(target_velocity - turn_velocity/1.5) * VEL_PERCENT / 100
```

You can see a few adjustments. `VEL_PERCENT` is defined based on the particular robot ([see this section](#programming-1)). This was added because Barron was simply too fast, and was difficult to control. Similarly, the `turn_velocity` is divided by 1.5 to make it easier to control how much the robot turns. Though it feels more natural because the turning joystick is sent through the logistic function:

```python3
turn_velocity = get_velocity(turn_stick, 100)
```

It is still very sensitive after this. Turning it completely right would otherwise make the robot turn on the spot rather than turning right and moving on.

Here's what the controller curve looks like:

{{controller_curve.png|0.8}}

### Drivetrain from scratch implementation
`Aseer`

I felt that I wasn't learning that much about robotics programming just controlling the drivetrain using simple VEX drivetrain commands. That's why I decided to program the drivetrain by hand. There are a few problems that must be considered:

  * Given the rotation position of the axles over time, where is the robot?
  * How can the robot's velocity be calculated consistently, accounting for the variance in the Python runtime?
  * How can the robot correct error in its calculations?

The specific implementation can be seen here:
```python
# 1. Get the new positions of the motors (say, 400 degrees)
left_position_new = self.left_group.position(DEGREES)
right_position_new = self.right_group.position(DEGREES)

# 2. Get the change in motor position (say it went from 380 to 400 degrees, so 20 degrees)
delta_left_position = left_position_new - self.left_position
delta_right_position = right_position_new - self.right_position

# 3. Get the change in distance for each side of the robot (for 20 degrees on 4" that is 1.77 cm)
delta_left_distance = convert(delta_left_position, "deg", "rad") * WHEEL_RADIUS
delta_right_distance = convert(delta_right_position, "deg", "rad") * WHEEL_RADIUS

# 4. The average of the two is how far it went forward in total (as a vector)
delta_forward_distance = (delta_left_distance + delta_right_distance) / 2

# 5. The difference between the two over the width of the wheelbase is how much it turned.
delta_angle = (delta_right_distance - delta_left_distance) / self.wheelbase

# 6. Update data
self.angle += delta_angle
self.x += delta_forward_distance * math.cos(self.angle)
self.y += delta_forward_distance * math.sin(self.angle)
```

1. Retrieve the position of the encoders inside the motors according to the motor group objects.
2. Find out how much the position has changed since the last query.
3. Find out how much each side of the robot has moved based on how much the motor turned. The `convert` table is defined in another function.
4. The forward distance of the robot is the average of the left and right distance.
  * Ex: 2 and -2 make 0, since this corresponds to turning on the spot
  * Ex: 2 and 2 make 2, since this corresponds to moving forward
5. The change in angle is the difference between the right and left distances travelled, divided by the width of the robot.
6. Finally, put the calculated values back in the function.

Because of the way this algorithm is implemented, it doesn't actually matter how much time has passed. Despite that, we still want to run this algorithm at a reasonable rate, and not bog down the rest of the system with pointless calculations. We also want to run it in parallel with the rest of the code. How can we solve both of these problems?

```python
class RoboData:
    def __init__():
        # ...

        threading.Thread(target=self.loop).start()

    def loop():
        start_time = time.perf_counter()
        end_time = time.perf_counter()
        time_spent = end_time - start_time

        # The code goes here.

        time.sleep(max(0, 1/FREQUENCY - time_spent))
```

This uses functions from both the `threading` and `time` modules to ensure that the code runs at a specific frequency. It is evident what it does, but you might be wondering about the part `time.sleep(max(0, 1/FREQUENCY - time_spent))`. In the case that the time to sleep is negative, that means that the code is running too slow due to external factors. This is not a problem, it just means that we shouldn't wait to execute the next cycle.

The reason to limit the rate at all, rather than using `while True` is because otherwise a bunch of processing power would be used on pointlessly calculating something that isn't even that accurate. We're not writing spinlocks here.

# Barron
While the team was iterating over the design of Allen 2.1, we wanted to explore a different design for the robot, and we also wanted to test software while the others were busy with the subsystems on the other robot. Barron was designed to cover a large footprint, with an aluminium-only chasis. It was impractically fast at full speed, so the speed and turning was limited in software.

## Design
Barron was designed to be a sort of opposite to Allen. Allen is heavy and has a low centre of mass, while Barron is light. Barron is very wide, barely within the size limit, while Allen has a compact form, focusing on height instead.

### Elevation system
We used Barron to test the elevation systems that would eventually be used on Allen, as Allen was broken at the time.

{{elevation_design_side_view.jpg|0.8}}

This is the first design we used for the elevation system, not including using the clawbot claw for this.

{{elevation_mechanism_close_up.png|0.8}}

This design uses a metal beam on a rail. It is tensioned into the open position by a rubber band which is pulling the head of one part to the tail of another part. The winch system pulls the ends together against the rubber band. To use it, the tension on the mechanism is released by the motor, allowing it to extend and reach the second rung of the ladder. The motor is turned around, pulling the parts together and pulling the robot up. The motor itself is geared for torque, along with being a red motor.

Limitations of this design:

* If we are not careful, the rails could slip, separating them.
* The rubber band could snap, disabling the system. Especially since the rubber band is stretched a lot and the robot may be transported in the cold.
* The design is very dangerous. If the motor is disabled in the tensioned position, it suddenly becomes impossible to release the mechanism, unless the brake mode on the motor is disabled.
* The design could put stress on the motor, causing it to overheat.
* There is a knot in the string, as it is two strings tied together.

## Programming
Barron shares the same code with Allen, but with a few changes. It was annoying to change the configuration code every time, and it didn't make sense to have two copies of code that always changes, so I came up with this solution:
```python
if NAME.upper() == "ALLEN":
    REVERSED = True
    GEAR_CARTRIDGE = GearSetting.RATIO_18_1
    VEL_PERCENT = 100

    # Drivetrain settings (mm)
    WHEEL_DIAMETER = 4
    # ...

elif NAME.upper() == "BARRON":
    # ...
```

This way, anything that is different about the robots is stored in the configuration.
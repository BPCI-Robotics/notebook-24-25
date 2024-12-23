---
title: "Engineering Notebook - High Stakes 24-25"
author: ["Birchmount Robotics"]
date: "{{DATE}}"
subject: "Robotics"
keywords: [Robotics, VRC]
lang: "en"
toc: true
toc-own-page: true
page-background: "media/background.pdf"
page-background-opacity: 0.15
header-includes:
  - \usepackage{cancel}
...

# About us
Hello! We are the VEX robotics team at Birchmount Park Collegiate Institute in Scarborough, ON. We have been active for about two years. In that time, we learned a lot as we worked together, failed, and triumphed. Our team is composed of exceptionally bright students who are either in the gifted program or might as well be in it. Our members have different strengths, and are really able to exercise their talents in the Robotics room.

We will now walk you through the various robots and designs that we have worked on in the past, and what we learned from them. Everything we learned from our previous designs would enable us to create better and better robots, eventually culminating in the robot we brought to this competition.

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

# Mathematical techniques

## Motor curve
One interesting discovery is the curve which regulates the speed of motors.

{{vex_smart_motor_curve.png|1.0}}

This is not intuitive at all unless one is looking for it. It's also not the solution one may expect. It is easy to program around it, though. When the speed is below a certain amount, set it to exactly whatever the magic number is (around 63) where the motor uses the most power. When it goes above that, switch to whatever speed the controller is set to. This allows you to use maximum torque, and therefore acceleration, for most of the velocity curve of the robot, while still being able to reach maximum speed.

The motor control curve also approximately snaps to 63 when the controller is near that range, because sometimes you want maximum power. This is good for pushing other robots or perhaps un-stucking the robot.

```python
if abs(current_speed) < 55:
    return sgn * 60
else:
    return sgn * max(logistic(val), 100)
```

## Drivetrain calculator spreadsheet
`Aseer`

This was a side project which turned out to be pretty useful for deciding on drivetrains. There is a lot you can calculate about a drivetrain just based on its gear and motor configuration. However, doing all the calculations by hand is pretty tedious and time consuming. What tool is good for doing a series of calculations and presenting it in a nice graphical format? A spreadsheet.

{{calculator_screenshot.png|1.0}}

> Note: This spreadsheet does not account for friction, and for certain drivetrains may be broken (values are negative). It also sometimes gives ridiculous results as it does not account for startup friction. I also don't know how to verify this tool.

When we are deciding which gear ratio to use, this tool can be really useful.

## Elevation calculations
It turns out that it's not that complicated to calculate how much power you need for elevation. You can use normal kinematics, or you could just reframe the problem as "how much energy do I need?" Since we are lifting the robot off the ground, we can use the formula for gravitational potential energy:

$E_p = mgh$

Where $m$ is the mass of the robot, $g$ is gravity ($9.8 \frac{m}{s^2}$), and $h$ is how high the elevation is. We can also use the formula:

$\Delta t = \frac{E}{P}$

Given the gravitational potential energy and the power of the motors, we can calculate how much time it will take to elevate.

We can also calculate how many rotations the robot has to make using these formulas:

\begin{align*}
  & C = \pi d \\
  & \theta = \frac{h}{C} \\
  & \Delta t = \frac{E}{P} \\
  & E = mgh \\
  & \omega = \frac{\theta}{\Delta t} \cdot 60 \frac{s}{m} \\
\end{align*}

Now we have everything we need, let's substitute in each of the formulas.

\begin{align*}
  \omega & = \frac{60 \cdot \theta}{\Delta t} \quad \text{Substitute  } \theta = \frac{h}{C} \\
  \omega & = \frac{60 \cdot \frac{h}{C}}{\Delta t} \\
  \omega & = \frac{60 \cdot h}{C \Delta t} \quad \text{Substitute  } \Delta t = \frac{E}{P} \\
  \omega & = \frac{60 \cdot h}{C \frac{E}{P}} \\
  \omega & = \frac{60 \cdot h P}{C \cdot E} \quad \text{Substitute  } E = mgh \\
  \omega & = \frac{60 \cdot \cancel{h} P}{C \cdot m g \cancel{h}} \\
  \omega & = \frac{60 \cdot P}{C \cdot m g} \quad \text{Substitute  } C = \pi d \\
  \omega & = \frac{60 \cdot P}{\pi d \cdot m g}\\
\end{align*}

And there it is, the magic formula. If you give $P$ as 11 watts, $d$ as the diameter of the winch spool in metres, $m$ as the mass of the robot in kilograms, and $g$ as gravity, you get the amount of RPM your winch should have at maximum.

There is a caveat, though. This does not apply to our system because the rubber band pulls on the winch as well. So a 2x factor is used (half the RPM) is used. Any way to achieve a specific RPM will give the correct torque as long as the motor is running at full torque.

# Pre-competition log

## Mon, November 11

### Problems and questions

* How are we going to make it so that the elevation system isn't under so much tension? Tension causing:
  * Motor strain.
  * Potential unlocking when elevation is scored.
  * Danger to people near the robot.

* How do we make the drivetrains stronger?

* What do other teams do?
  * How many manual points and autonomous points?
  * How do they score the points?
  * Can they score elevation points?
  * How much torque and acceleration do they have?
  * What is their offensive and defensive strategy?

* To do: fix the two robots
  * One has bent metal.
  * The other had half of its wheels fall off.

* How are we going to tackle the autonomous period?

* Can we climb higher on the ladder?

### What we did

* We decided to make a Google Forms to allow us to scout other teams in a consistent manner, logging:

  1. Are they playing an offensive or defensive strategy?
  2. What was special about their robot?

* Partially disassemble both robots, and cut axles. Our main problem with the wheels and gears in the drivetrain was that our axles were either too long or too short. This, we believe, will resolve the drivetrain strength issues. Also, we should implement safety protocols to prevent the robots from driving off the tables and destroying themselves.

* As for the ladder, we are working on improving the elevation system first, then climbing higher on the ladder.

* The important thing at this stage is testing the robots. By testing them, we had quickly figured out numerous flaws with the robots, allowing us to address them. We need to accelerate our progress, though.

### Tue, November 12

### What we did
`Aseer`

I decided to test the autonomous capabilities of the robot. I decided to add a drivetrain to the code, making measurements. We do not have a gyro or anything fancy, so it was up to the encoders inside the motors and the VEX standard library to do calculations.

## Thu, November 14

### What we did
This was the first day that we mostly devoted to letting the drivers practice on the field. We had assigned drivers by this point. Before we didn't see the point in assigning separate responsibilities for drivers and builders, but now we understand that this can increase efficiency. Especially considering that robotics has many members, some of them don't have anything to do.

### Problems encountered
Actually, the drive test went surprisingly well, but there was one glaring issue, which [reminded us of an earlier issue](#stuck-on-a-triball). The robot could drive onto a donut and get stuck. We didn't address this immediately, as the drivers were still getting used to the controls. The controls also didn't need much adjustment.

## Mon, November 18

### What we did
At this point, we wanted to lock in the design before the competition, as any breaking changes could lead to having an incomplete non-functional robot before the competition. So we resisted most changes. Current projects would have to run independently from the competition robot, such as the elevation system and a complex sensing autonomous system. For autonomous we settled on just using a simple blind "go forward and do this" autonomous system. We did not see complex autonomous systems anyway, so this made sense.

### PROS
Someone suggested using OkapiLib to program the robot. This would be considered a breaking change and a time consuming one, so like other projects, it was delayed until after the competition. This is because we would need to port our code to C/C++, which wouldn't be difficult but there are two programmers on the team, only one of them knows C. However, this would be very beneficial. This is because:

* Micropython is very limiting: it lacks not only syntactical sugar like f-strings but also the ability to import other files as modules. This makes it easy to get lost in the long single-file codebase and its global variables. It also does not come with every Python standard module, not just the obvious ones like `os`.

* Python isn't often used to code robots in the industry. For this, low-level languages like C are often used, especially to interface with a real-time kernel like PROS uses. Though it is more complex overall, you gain a lot more fine-grained control and performance, though for the VEX brain performance is irrelevant.

* OkapiLib provides many facilities to make it easier to code the autonomous period. This will definitely help us to win autonomous points in future competitions.

### Problems encountered
The robot still gets stuck on donuts. We also just have a lack of special things about the robot. It does not have an autonomous system and it does not have an elevation system. We don't have time for this as the day comes closer.

## Tue, November 19

### What we did
We finally fixed the issue where the robot would get stuck on a donut. This just involved adjusting the motors a little bit.

We also continued work on the elevation system. The new design involves three sections which nicely fold into each other.

## Thu, November 21

### What we did
Today, we started packing up everything and making final changes. Work is still being done to improve the reliability of the elevation system, and to make sure that it fits within the size constraint.

Today:

- More driving practice was done.
- The rudimentary autonomous system was quickly drafted and tested.
- The elevation system was improved such that it caught on itself less often.
- The code was heavily cleaned up.

### Elevation system

The issue encountered with the elevation system is that it would fit within the size limit when the motor is active, but expands a little bit when the motor is turned off. The system hardly fits within the size limit anyway. Some tweaks must be made to the design to allow it to fit.

You may ask, why are we working on the elevation system if we are not going to add anything? This is a sort of exception. The condition is that if the system can be made to work in time, it will be added. It's not a problem if it doesn't work, because it is only attached to the robot by three nuts and screws.

Here are some pictures:

{{elevation_system_bottom.jpg|0.5}}
{{elevation_system_middle.jpg|0.5}}

{{elevation_system.jpg|0.5}}
{{elevation_system_latch.jpg|0.5}}

One big limitation of the elevation is that, of course, it gets jammed. Part of this is because we do not have access to the usual pieces used for linear movement, like perhaps a rack-and-pinion system. Or at least a piece to make the pieces slide smoothly. It's all metal against metal. With that being said, it works.

### Code cleanup

{{commit_history.png|0.8}}

Without changing the code, we managed to remove a bunch of lines while also making the code clearer. This involved removing commented out code, removing global variables, and rescoping variables. The kill switch system was removed, as well as the ability to switch between two robots. This cleanup reduced the lines of code from 260 to 180.

This was an important learning experience. Especially as we switch to C/C++, readability and maintainability will be harder to achieve, especially through rapid iteration. 

This was experimented with before. There are some hacks with the C preprocessor which can make code more concise. For example,

```c
#define pressed(x)  controller_get_digital(CONTROLLER_MASTER, DIGITAL_##x)

void opcontrol() {
    // ...
    if pressed(L1) {
        do_something();
    }
    // ...
}
```

### Autonomous
The autonomous period is simple. All it does is move backwards to capture a stake, then puts the preloaded donut on it. Tomorrow, we will try to make the autonomous system pick up the field donuts. This will also be useful in the autonomous skills challenges.

### Intake bar
The intake bar was changed for a thicker one, as the donuts would end up bending the thinner one.

{{latest_intake_bar.jpg|0.5}}

## Fri, November 22

### What we did
Today was the last day before the competition.

- We finalized packing up and loaded everything into the teacher's car.
- We continued work on the autonomous system and the autonomous period.
- We did not do much driver practice today, as autonomous was a priority. The autonomous system is immature as we just made it yesterday.
- We indexed everything that we would be carrying to make sure that we could not forget everything.

## Thoughts

### Plans for the future
Due to the time pressure, there were a lot of things that we decided not to do. Things that we decided to tackle later. 

- Score on the high stake.
  - This would involve having a completely different donut-placing system, as the current one targets a stake in possession.

- Improve the autonomous system.
  - It should be able to pick up multiple donuts from the field in the autonomous period.
  - Perhaps it should use a sensing system instead of just a blind program. However this may be less reliable.

- Make the elevation system more reliable.
  - This is needed to score on the high stake anyway.
  - It also means that we won't have a situation where the robot gets stuck in the elevation position while the other teams move our stakes to the minus zone.

- Make the elevation system faster
  - There's two things to look at here: how can we increase the power in the winch, and how can we improve the design in general.
  - Two motors on the winch could make it faster just by the torque. A better idea is to gear both of them 2:1 to double the speed. This provides equivalent torque but at twice the speed.
  - This will also address the minus zone problem, as it makes it take less time to elevate.

- Figure out how to knock over stakes, or how to right them.
  - This is because a common strategy is to knock over stakes so that it is difficult to move them into another zone or to descore them.
  - Since stakes are bottom-heavy, it is hard to knock them over simply by ramming into them. A special mechanism may be needed.
  - The same mechanism could even right a stake.

- Try to improve the controls.
  - We only addressed the control curve once. There could be a better control curve that we are missing out on, though. The drivers expressed that they have no problem with the current controls, but we could possibly improve performance with better controls

  - For example, it could be a step function with certain set speeds. Often you don't need to go at a specific speed. Just at 0%, 50%, 100%.

- Program in PROS.
  - This has already been discussed in detail.

There is a lot to get done, and it's not like we finished everything today. Today was just the beginning, the day we became a proper VEX Robotics team. We should take a break, though, as these past two weeks have been tough.

# After the competition

## Mistakes made
Many mistakes were made during the competition, and our potential was not truly realized. In terms of ranking, we did about as well as we did last time. That is to say, not well. We tested our robot, though, and it worked really well, so what went so wrong?

### Height limit
When one is forced to change the robot in such a way that it compromises the whole strategy, it is hard to recover from that. It's weird that that happened to us twice. In the first competition it was because our pneumatics tank failed, this time it was because we were slightly over the height limit.

A lot of time was spent just adjusting the donut subsystem for that very specific height. We thought it wouldn't be a problem that it was half an inch over the limit, but they did not allow the robot. So we had no choice but to change it.

Of course to make sure that it works, it takes a lot of tuning. Now we have a donut elevator that is very unlikely to work. And it did not work. This was the main reason we were not successful.

### Practice was inaccurate
Of course we did a lot of driver practice this time, we would not make that mistake again. There were two problems with this, though. We changed our subsystem at the beginning of the competition, which seemed to completely change the dynamics of the robot. The practice also did not consider what the field conditions were like. In our practice, we:

* Took our time to pick up a stake.
* Picked up donuts one by one, with only the focus on the donuts.
* Put the stake in the corner.

But in the actual matches, we spent more time:

* Defending the corner stakes against others.
* Trying to get the other team's stake out of the positive corner.

And we never picked up a donut. This is because our robot was not even capable of this, but the important observation is this:

> Once there are a few full stakes, the game is to get them in the corners.

There is no way to win otherwise, since your stake will be moved to the minus corner, or the other team capitalizes on the double points. Another observation was the importance of wall stakes, which we did not even think about. Mostly because we didn't have that many pneumatic parts. It seems that wall stakes are important, because they can be a tie breaker when all the teams have already put the stakes in the corners. Stakes which are very hard to move out of the corners.

### Autonomous never worked
When trying the autonomous system, it seemed to work just fine, but on the field, it did not catch the stake even once. It would attempt to catch the stake, but fail to hold on to it.

The only time the robot actually scored in autonomous was when it captured the stake, picked up a single donut, and put it on. It actually dropped the preload donut because the code was wrong, and turned on the lift before picking the stake.

We later realized why this is the case:

### The robot was too fast
- The unbalanced drivetrain meant that when decelerating quickly, the robot would tip, making it fail to catch the stake.

Because of the subsystem, the weight was extremely unbalanced on the robot. Whenever it would accelerate, it would tilt up, which would cause to lose grip and get stuck on donuts all the time.

  {{robot_tip_over.png|1.0}}

  In this picture, you can see the dynamics of the robot as it tried to pick up a stake in autonomous, or even in driver control. Keep in mind that forces which oppose each other in different areas will create a torque, even if they add to zero. 
  
  In the top left picture, there is no force on the robot, and it is simply moving forward.

  In the top right picture, the brakes are slammed, which creates an opposing force on the bottom of the robot. However, at the top of the robot, there is still a bunch of inertia from the heavy donut elevator, so it continues to apply a force forward. This creates a torque which lifts the back of the robot.

  In the bottom left picture, the overall torque on the robot reverses as this momentum is depleted, causing it to tip in the other direction due to gravity.

  In the bottom right picture, the robot overshoots, causing it to let go of the stake. This is because of moment of inertia; since the robot is already rotating in that direction, it wants to continue rotating.

- This also means that the robot would tip while accelerating too quickly.

  {{robot_wheel_tipping.png|1.0}}


## Action plan
From what we learned from the competition, we formulated an action plan for how we would improve the robot. Actually, we would rebuild the entire robot from scratch, as we are going to replace our drivetrain motors. The design seemed fundamentally flawed anyway, so rebuilding from scratch would allow us to fully realize our vision for a competitive robot. This would be the one that brings us from being a lower-mid team to a higher-mid, nearly good team.

The items were:

* {{TODO}}

# Hawk 1A
Hawk 1A is a robot on an aluminium drivetrain. It has four 600 RPM motors and is geared down to a speed of 360 RPM on 3.25" wheels.

Hawk 1A's drivetrain is more traditional, valuing speed over torque, as VEX motors have a pretty high torque anyway.

## Design process

### Four motors vs. six motors
This was a pretty big debate, and one that we have had before. Obviously, having 1.5x more torque on the drivetrain is good. There are other benefits too.

**Benefits of 6 motors**

* Other teams' robots are less able to push the robot around, which helps in offensive/defensive situations like putting a stake in the positive corner.

* The motors will generally heat up less. As long as the acceleration is limited to a reasonable amount, the motors will not overheat every single time we compete. After all, power consumption is proportional to torque, not to angular velocity. The load is distributed over more motors, so it allows less time between rounds.

* One can make the robot faster without sacrificing too much acceleration. Acceleration, as we realized, should be sacrificed anyway.

* {{TODO}}

### CAD

## Programming

### Mistakes made
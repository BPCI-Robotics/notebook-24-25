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
Hello! We are the VEX robotics team at Birchmount Park Collegiate Institute in Scarborough, ON. We have been active for about two years. In that time, we learned a lot as we worked together, failed, and triumphed. Our team is composed of exceptionally bright students who are either in the gifted program or might as well be in it. Our members have different strengths, and have the opportunity to express their talents in the robotics room.

{{team_photo.png|1.0}}

## Our members (left to right)

* **Turhan**: Programmer, Builder
* **Wesley**: Programmer, Builder
* **Colin**: Builder/Designer, Driver
* **Rohan**: Driver
* **Aseer**: Programmer, Notebooker
* **Tyler**: Builder/Designer
* **Wadid**: Outreach
* **Daniel**: Builder, Strategy/Scouting

This notebook will outline our design process as we worked on two robots for the VRC High Stakes competition. We went through a lot of design iterations, and worked as hard as we could in our limited time.

# Previous Competitions

## Lessons learned
In November, we are going to compete in our first competition this season, and our third competition overall. The first two were for Over Under.

Let's review what we learned from competing in Over Under:

* Time management, especially on a school team, is very important.
  * If it is too complex and hardly worth it, don't do it.
  * If you are unsure whether it will work, and it takes a long time, don't do it.
  * If you can't get something to work, scrap it.
  * Spend most of your time working on the most important systems, like the drivebase and the scoring mechanism.
  * Find work for people to do which doesn't involve the robot.

* The Clawbot drivetrain is just not that good. Popular drivetrains:
  * have six motors,
  * six or more small wheels,
  * a really high RPM (360 or higher),
  * are bottom-heavy,
  * and often use tank-drive,

* On the other hand, the drivetrain we used had:
  * four motors,
  * four large wheels,
  * 200 rpm,
  * was unbalanced,
  * and had independent wheels.

* There are many extra pieces of equipment which are used often. These include:
  * Color sensor,
  * Accelerometer (IMU),
  * Rotation encoders + tracking wheels,
  * Extra pistons,
  * Flex wheels and traction wheels,
  * 5.5 watt motors,
  * and high traction mats.

* Some other tips include:
  * There isn't a good reason to use anything but nylock nuts. Keps nuts and regular nuts fall off really easily.
  * However, keps nuts can be quickly added and removed, and are good for prototyping.
  * The pressure regulator can be used to reduce the air consumption of the pneumatics system.
  * Driver practice is very important! It's not just something you do for a day after building!
  * Third-party websites sell VEX-legal parts at good prices, or simply when they're hard to come across.

# November Competition

## Mathematical techniques

### Motor curve
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

### Drivetrain calculator spreadsheet
`Aseer`

This was a side project which turned out to be pretty useful for deciding on drivetrains. There is a lot you can calculate about a drivetrain just based on its gear and motor configuration. However, doing all the calculations by hand is pretty tedious and time consuming. What tool is good for doing a series of calculations and presenting it in a nice graphical format? A spreadsheet.

{{calculator_screenshot.png|1.0}}

> Note: This spreadsheet does not account for friction, and for certain drivetrains may be broken (values are negative). It also sometimes gives ridiculous results as it does not account for startup friction. I also don't know how to verify this tool.

When we are deciding which gear ratio to use, this tool can be really useful.

### Elevation calculations
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

## Pre-competition log

### Mon, November 11

**Problems and questions**

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

**What we did**

* We decided to make a Google Forms to allow us to scout other teams in a consistent manner, logging:

  1. Are they playing an offensive or defensive strategy?
  2. What was special about their robot?

* Partially disassemble both robots, and cut axles. Our main problem with the wheels and gears in the drivetrain was that our axles were either too long or too short. This, we believe, will resolve the drivetrain strength issues. Also, we should implement safety protocols to prevent the robots from driving off the tables and destroying themselves.

* As for the ladder, we are working on improving the elevation system first, then climbing higher on the ladder.

* The important thing at this stage is testing the robots. By testing them, we had quickly figured out numerous flaws with the robots, allowing us to address them. We need to accelerate our progress, though.

### Tue, November 12

**What we did**

`Aseer`

I decided to test the autonomous capabilities of the robot. I decided to add a drivetrain to the code, making measurements. We do not have a gyro or anything fancy, so it was up to the encoders inside the motors and the VEX standard library to do calculations.

### Thu, November 14

**What we did**

This was the first day that we mostly devoted to letting the drivers practice on the field. We had assigned drivers by this point. Before we didn't see the point in assigning separate responsibilities for drivers and builders, but now we understand that this can increase efficiency. Especially considering that robotics has many members, some of them don't have anything to do.

**Problems encountered**

Actually, the drive test went surprisingly well, but there was one glaring issue, which reminded us of an earlier issue (we got stuck on a triball). The robot could drive onto a donut and get stuck. We didn't address this immediately, as the drivers were still getting used to the controls. The controls also didn't need much adjustment.

### Mon, November 18

**What we did**

At this point, we wanted to lock in the design before the competition, as any breaking changes could lead to having an incomplete non-functional robot before the competition. So we resisted most changes. Current projects would have to run independently from the competition robot, such as the elevation system and a complex sensing autonomous system. For autonomous we settled on just using a simple blind "go forward and do this" autonomous system. We did not see complex autonomous systems anyway, so this made sense.

**PROS**

Someone suggested using OkapiLib to program the robot. This would be considered a breaking change and a time consuming one, so like other projects, it was delayed until after the competition. This is because we would need to port our code to C/C++, which wouldn't be difficult but there are two programmers on the team, only one of them knows C. However, this would be very beneficial. This is because:

* Micropython is very limiting: it lacks not only syntactical sugar like f-strings but also the ability to import other files as modules. This makes it easy to get lost in the long single-file codebase and its global variables. It also does not come with every Python standard module, not just the obvious ones like `os`.

* Python isn't often used to code robots in the industry. For this, low-level languages like C are often used, especially to interface with a real-time kernel like PROS uses. Though it is more complex overall, you gain a lot more fine-grained control and performance, though for the VEX brain performance is irrelevant.

* OkapiLib provides many facilities to make it easier to code the autonomous period. This will definitely help us to win autonomous points in future competitions.

**Problems encountered**

The robot still gets stuck on donuts. We also just have a lack of special things about the robot. It does not have an autonomous system and it does not have an elevation system. We don't have time for this as the day comes closer.

### Tue, November 19

**What we did**

We finally fixed the issue where the robot would get stuck on a donut. This just involved adjusting the motors a little bit.

We also continued work on the elevation system. The new design involves three sections which nicely fold into each other.

### Thu, November 21

**What we did**

Today, we started packing up everything and making final changes. Work is still being done to improve the reliability of the elevation system, and to make sure that it fits within the size constraint.

Today:

- More driving practice was done.
- The rudimentary autonomous system was quickly drafted and tested.
- The elevation system was improved such that it caught on itself less often.
- The code was heavily cleaned up.

**Elevation system**

The issue encountered with the elevation system is that it would fit within the size limit when the motor is active, but expands a little bit when the motor is turned off. The system hardly fits within the size limit anyway. Some tweaks must be made to the design to allow it to fit.

You may ask, why are we working on the elevation system if we are not going to add anything? This is a sort of exception. The condition is that if the system can be made to work in time, it will be added. It's not a problem if it doesn't work, because it is only attached to the robot by three nuts and screws.

Here are some pictures:

{{elevation_system_bottom.jpg|0.5}}
{{elevation_system_middle.jpg|0.5}}

{{elevation_system.jpg|0.5}}
{{elevation_system_latch.jpg|0.5}}

One big limitation of the elevation is that, of course, it gets jammed. Part of this is because we do not have access to the usual pieces used for linear movement, like perhaps a rack-and-pinion system. Or at least a piece to make the pieces slide smoothly. It's all metal against metal. With that being said, it works.

**Code cleanup**

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

**Autonomous**

The autonomous period is simple. All it does is move backwards to capture a stake, then puts the preloaded donut on it. Tomorrow, we will try to make the autonomous system pick up the field donuts. This will also be useful in the autonomous skills challenges.

**Intake bar**

The intake bar was changed for a thicker one, as the donuts would end up bending the thinner one.

{{latest_intake_bar.jpg|0.5}}

### Fri, November 22

**What we did**

Today was the last day before the competition.

- We finalized packing up and loaded everything into the teacher's car.
- We continued work on the autonomous system and the autonomous period.
- We did not do much driver practice today, as autonomous was a priority. The autonomous system is immature as we just made it yesterday.
- We indexed everything that we would be carrying to make sure that we could not forget everything.

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

## After the competition

### Mistakes made
Many mistakes were made during the competition, and our potential was not truly realized. In terms of ranking, we did about as well as we did last time. That is to say, not well. We tested our robot, though, and it worked really well, so what went so wrong?

**Height limit**

When one is forced to change the robot in such a way that it compromises the whole strategy, it is hard to recover from that. It's weird that that happened to us twice. In the first competition it was because our pneumatics tank failed, this time it was because we were slightly over the height limit.

A lot of time was spent just adjusting the donut subsystem for that very specific height. We thought it wouldn't be a problem that it was half an inch over the limit, but they did not allow the robot. So we had no choice but to change it.

Of course to make sure that it works, it takes a lot of tuning. Now we have a donut elevator that is very unlikely to work. And it did not work. This was the main reason we were not successful.

**Practice was inaccurate**

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

**Autonomous never worked**

When trying the autonomous system, it seemed to work just fine, but on the field, it did not catch the stake even once. It would attempt to catch the stake, but fail to hold on to it.

The only time the robot actually scored in autonomous was when it captured the stake, picked up a single donut, and put it on. It actually dropped the preload donut because the code was wrong, and turned on the lift before picking the stake.

We later realized why this is the case:

**The robot was too fast**

- The unbalanced drivetrain meant that when decelerating quickly, the robot would tip, making it fail to catch the stake.

Because of the subsystem, the weight was extremely unbalanced on the robot. Whenever it would accelerate, it would tilt up, which would cause it to lose grip and get stuck on donuts all the time.

  {{robot_tip_over.png|1.0}}

  In this picture, you can see the dynamics of the robot as it tried to pick up a stake in autonomous, or even in driver control. Keep in mind that forces which oppose each other in different areas will create a torque, even if they add to zero. 
  
  In the top left picture, there is no force on the robot, and it is simply moving forward.

  In the top right picture, the brakes are slammed, which creates an opposing force on the bottom of the robot. However, at the top of the robot, there is still a bunch of inertia from the heavy donut elevator, so it continues to apply a force forward. This creates a torque which lifts the back of the robot.

  In the bottom left picture, the overall torque on the robot reverses as this momentum is depleted, causing it to tip in the other direction due to gravity.

  In the bottom right picture, the robot overshoots, causing it to let go of the stake. This is because of moment of inertia; since the robot is already rotating in that direction, it wants to continue rotating.

- This also means that the robot would tip while accelerating too quickly.

  {{robot_wheel_tipping.png|1.0}}


**Action plan**

From what we learned from the competition, we formulated an action plan for how we would improve the robot. Actually, we would rebuild the entire robot from scratch, as we are going to replace our drivetrain motors. The design seemed fundamentally flawed anyway, so rebuilding from scratch would allow us to fully realize our vision for a competitive robot. This would be the one that brings us from being a lower-mid team to a higher-mid, nearly good team.

# February Competition
On February 2nd, we went to a city qualifier, where our alliance placed second, only getting defeated in the final match. We also placed second in skills. This was far more successful than we had ever been before. Our hard work paid off, and we realized that we learned something. What factors led to this success, and what can we learn from this?

## Eye of Rah
Eye of Rah is a robot on an aluminium drivetrain. It has six 600 RPM motors and is geared down to a speed of 360 RPM on 3.25" wheels. We are building this robot for the February qualifiers. We want it the best we can, of course, but we are always limited on time, so we are not being as ambitious as we would usually be.

We want to make this the robot which shows how much we learned. Our previous robots were really simple, but now that we have access to more advanced parts, we hope to build a more advanced and capable robot.

## Design process

### Four motors vs. six motors
There was always resistance against having six motors on the robot, with the main argument being that we would only have two motor slots left for subsystems. At the time, we did not really have pneumatics, and we didn't have 5.5 W half motors. Our final decision was to use six motors on the drivetrain. Here's why:

* Less likely to overheat: When there are six motors, the load is spread across them, and each one has to give less torque overall.

* Everyone else uses it: The torque afforded by six motors allows one to have a much faster drivetrain, while still having good acceleration, handling, and pushing power.

### Choice of metal
We always thought that steel was better because it makes the robot heavier, therefore more difficult to push around, and it makes the robot stronger and more rigid. We quickly realized that the important thing is actually agility, and being able to perform tasks quickly. Sometimes the robot can get tangled with another robot, but this is balanced because it means that the two robots are both wasting time.

### Mogo Clamp
Our mogo clamp utilizes 2 50mm bore pistons to clamp the piston and retain possession of the goal. However, one difference from other teams is that we do not have a lot of force pushing down on the stake. This comes with downsides, such as not being able to consistently clamp corners and being able to shift. However, this also allows us to use minimal air to grab a piston, allowing us to grab a full stake with just 20 psi. The shifting also was not bad enough to justify a full change of the system, especially considering the small time period until provincials.

Using two pistons seemed to allow the force to be spread more evenly through the system, as well as providing more force, of course.

### CAD
This time, we decided that CAD was important. So we tried two different softwares, Autodesk Fusion 360, and Onshape. Both of them proved useful in their own way. Fusion 360 is very powerful, with features like physics simulation, and better support for custom desigining parts like the ones made from polypropylene. However, it is demanding in terms of computer resources, and it does not run well on school-administered Chromebooks. Onshape has the essential features needed to put together a robot, runs well on all computers, and is easier to learn. When desigining the robot for the competition, we decided that we do not have time for CAD, and we would continue our iterative design process using the robot itself.

### Wall stake mechanism
We wanted a mechanism for the wall stake, because in a few games, this can be a tiebreaker. When both positive corners are full with both teams' donuts, there are few options left to score. One particularly popular one was scoring on the wall stakes or alliance stakes. Many teams had a mechanism for doing so, and we went with the Lady Brown mechanism, because it seemed easier to implement.

One problem that we encountered in testing was that the motor, which was set to `HOLD`, would overheat while holding the donut. This makes sense. If the motor is powered but isn't doing work, all of the energy is going into heating the coils inside the motor. We decided that we only really wanted to score one or two wall stake donuts, so this was not a problem. We also made it so that the motor is unpowered when in the resting position.

But the main problem was that operating the mechanism took too long. The procedure to score the donut was convoluted, and the drivers did not have much time to practice. So in every game, it was more effective to simply pick up another stake and score some more donuts.

## Programming

### LemLib
The programmers on the team did some research on control systems for the robot, and now we understand them. It would be a good project to implement them, but we understand our constraints (small team, few hours). So we wanted a sort of all-in-one solution for PID and path-following. PROS seemingly insists upon OkapiLib, though in the latest versions of PROS it is not supported. LemLib looked promising, as it was feature-rich and supported. LemLib makes it trivial to configure PID, path-following algorithms, and driver control schemes. However...

### Switch away from PROS
When we were working the PROS code, we encountered a problem where only half of the drivetrain would move, and we could not figure out the issue (though it was probably that the motors were incorrectly configured). At that point, we decided to scrap it, because we did not have any time to tune PID, and Python would be much simpler to work with. So I rewrote the Python codebase to clean it up a bit, and this was quite successful on the field.

PID and pure pursuit are important for many autonomous systems, so why didn't we need it? It's because we gave a lot of time for the robot to complete its routine, which allowed it more accuracy, and prevented it from tipping so much. This means making the robot move slowly, as well as putting long wait statements between routines. The calls to `drivetrain.drive_for` were decided simply by trial and error. 

### The robot worked!
The primary method of scoring in this competition is to put rings on the stake which the robot is holding, then to get it in the positive corner. The secondary method is to score on wall stakes, which is a sort of tiebreaker when both positive corners have full stakes. But weirdly, in most cases we won because of the autonomous bonus. With a few small changes to the autonomous code we used last competition, every single time it would pick up the stake, and score a single ring. The other teams didn't have an autonomous routine, so this gave a huge advantage, not just in autonomous win points, but also in having a stake before the game starts.

I believe that if we wrote the autonomous code from scratch, we wouldn't have had enough time to make it work as expected. Trying to grab a stake, then a donut is a difficult thing to do which requires some level of precision.

### Python driving control system
We still had the problem where our robot would often tip. This was for two reasons. It was a bit top heavy, as this was not a design consideration when we were building it. Another was that the six wheels were close to the centre of the robot. So of course it had room to tip. I proposed using a PID (proportional-integral-derivative) controller to try and minimize the tipping when the driver moved the controller. Here's how I implemented it.

```python
# Value of offset - when the error is equal zero
offset = 0

time_prev = brain.timer.time(SECONDS)
e_prev = 0

Kp = self.Kp
Ki = self.Ki
Kd = self.Kd

I = 0

while self.running:
    sleep(1 / 60, SECONDS)

    time = brain.timer.time(SECONDS)

    e = self.setpoint - self.get_val()
        
    P = Kp*e
    I += Ki*e*(time - time_prev)
    D = Kd*(e - e_prev)/(time - time_prev)

    MV = offset + P + I + D

    e_prev = e
    time_prev = time
    I *= 0.99

    self.set_val(self.get_val() + MV)
```

This uses a class to abstract over the complex state of the PID system, and uses `__call__` to make it behave as if it were a regular motor-setting function. The reason why a class abstraction is used is to allow different PID controls for the drive and the turning. They are declared like so:

```python
set_turn_velocity_PID = PID_Motor(0.6, 0.2, 0.1, get_turn_velocity, drivetrain.set_turn_velocity)
set_drive_velocity_PID = PID_Motor(0.6, 0.2, 0.1, drivetrain.velocity, drivetrain.set_drive_velocity)
```

And they are invoked like so:

```python
controller.axis1.changed(set_drive_velocity_PID, (controller.axis1.position(),))
controller.axis3.changed(set_turn_velocity_PID, (controller.axis3.position(),))
```

Notice how this gets passed to `__call__` to change the setpoint.

We had little time to access the robot while working on this, so how did we tune PID? By making a simulation of the motors, and tuning it based on that. To simulate the robot drivetrain, there were a few parts. The main part was to implement inertia such that the motors don't instantly change speed. Another thing was to simulate the robot crashing, which can be done by forcing the velocity to be zero for a certain period of time. This is important for diagnosing integral windup, and seeing the behavior in unusual situations.

Here is an example graph:
```
Waiting for velocity to be 100
6.5 -> 100              [##                                      ]
16.9 -> 100             [######                                  ]
27.3 -> 100             [##########                              ]
37.7 -> 100             [###############                         ]
48.1 -> 100             [###################                     ]
58.5 -> 100             [#######################                 ]
68.9 -> 100             [###########################             ]
79.3 -> 100             [###############################         ]
88.4 -> 100             [###################################     ]
98.8 -> 100             [####################################### ]
101.6 -> 100            [########################################]
100.6 -> 100            [########################################]
Set velocity to 100 which took:  0.8 seconds.
Waiting for velocity to be 0
84.4 -> 0               [#################################       ]
64.4 -> 0               [#########################               ]
44.4 -> 0               [#################                       ]
24.4 -> 0               [#########                               ]
4.4 -> 0                [#                                       ]
2.1 -> 0                [                                        ]
Set velocity to 0 which took:  0.4 seconds.
...
```

However, as I tuned PID, I realized that the behavior was not as I expected. I couldn't ever get the behavior I was looking for. We eventually decided that PID was too complex for our use case. Someone suggested using a rolling-average function instead. So I did just that.

```python
class RollingAverage:
    def __init__(self, size, anti_lag):
        self.size = size
        self.anti_lag_enabled = anti_lag

        self.data = [0.0] * self.size
        self.pos = 0

    
    def __call__(self, val: float) -> float:

        # Add to the buffer, with a dead zone from -5 to 5
        self.data[self.pos] = 0 if -5 <= val <= 5 else val

        # Iterate to the next position
        self.pos = (self.pos + 1) % self.size
        
        ret = sum(self.data) / self.size
        ret_sign = -1 if ret < 0 else 1
        
        # Anti lag makes any value above 40 equivalent to 100.
        if abs(ret) > 50 and self.anti_lag_enabled:
            return ret_sign * 100

        return ret

# ...

control_accel = RollingAverage(size=10, anti_lag=True)
control_turn = RollingAverage(size=10, anti_lag=False)

def do_drive_loop() -> None:
    accel_stick = control_accel(controller.axis3.position())
    turn_stick = control_turn(controller.axis1.position())

    lm.spin(FORWARD, accel_stick - turn_stick, PERCENT)
    rm.spin(FORWARD, accel_stick + turn_stick, PERCENT)
```

The way this code works is that it creates a circular buffer of the inputs to the function. When the return value of the function is asked, it returns the mean value of the entire buffer. This makes it a very simple system for smoothing inputs. But there was a big problem with all this.

### The tipping problem
The reason why we were trying to control the driver input to the robot was because the robot kept tipping as it was driving. But this was a misguided idea and turned out to be unhelpful. The reason for this is that there must be a strong correlation between controller input and the behavior of the robot, otherwise the driver has trouble making the connection. The robot->eye->brain->hand->controller->robot loop runs very tightly, and anything which loosens this makes the robot very difficult to control, manifesting as "input lag." In the rolling average function, I tried to mitigate this by making all velocities above 50 equivalent to 100, but this did not help.

So what is the problem? The fact that the robot is able to tip at all. The primary problem is that the robot itself is unbalanced. This is not trivial to resolve, and would require a full rebuild, so we looked at another problem. The wheels are far away from the edge of the robot. So we fixed this by moving the wheels to the end of the robot, leaving a gap between the wheels.

{{diagram_drivebase_adjustment.png|1.0}}

### Color sorting
One strategy that many teams implemented was using a color sensor to detect what color the donuts were, and handle them accordingly. We also tried to do something like this, but we did not have a color sensor. So, instead, we used the color sensor. The color sensor can be imprecise, and it's not designed to work at short range. Nevertheless, it was better than nothing. The way it works is that it captures both the red signal and blue signal, figures out which one is present, and then measures the size of the donut. If the donut is not filling a substantial area of the sensor, it is probably on the field, rather than on the donut elevator. This worked, but there was no time to implement this.

### Autonomous control
To control the autonomous period, we simply copied the code we used at the last competition, and made a few small changes. It is simply instructing the drivetrain to move certain distances and turn certain amounts. There are also wait statements to ensure that the robot stabilizes before doing anything. This makes the positions of the robot more predictable, making the autonomous overall more consistent. It was pretty consistent, and won us a few matches. We never did autonomous skills.

## Strategy
We never strictly strategized through the games, we simply did what we felt was right. The important thing to consider is that matches have very limited time, so time must be used wisely.

So when we were in the audience, we would instruct the driver on what the best use of time was at the current moment.


## {{TODO}} (After February Competition) or (Provincials)
---
title: "Birchmount Robotics - Engineering Notebook - High Stakes 24-25"
author: [Aseer Tayeem]
date: "2024-10-10"
subject: "Robotics"
keywords: [Robotics, VRC]
lang: "en"
toc: true
toc-own-page: true
page-background: "media/background.pdf"
page-background-opacity: 0.15
table-use-row-colors: false
...

# About us
Hello! We are the VEX robotics team at Birchmount Park Collegiate Institute in Scarborough, ON.


## Our members
<!--+--------------------------------+----------------------------------+
| Aseer ![](logo.png){width=50,height=50} | Tyler ![](logo.png){width=50,height=50}   |
| Colin ![](logo.png){width=50,height=50} | Wesley ![](logo.png){width=50,height=50}  |
| Rohan ![](logo.png){width=50,height=50} | Turhan ![](logo.png){width=50,height=50}  |
| Wadid ![](logo.png){width=50,height=50} | Parthib ![](logo.png){width=50,height=50} |
+--------- -----------------------+----------------------------------+-->

<table>
    <tr>
        <td>Aseer</td>
        <td>![](logo.png){width=50px,height=50px}</td>
    </tr>
</table>

# Allen
Allen was the first robot we ever brought to a competition, and he served us well. He is named for our mascot Allen, who is the monkey responsible for bringing Allen wrenches to the team members. It was a very simple robot which had gone through many designs, as we were learning a lot about how to design robots.

## Design
Allen was built on an all-iron drivetrain, based on the clawbot. 

### Drivetrain

### Intake mechanism

### Launcher mechanism

## Problems encountered

### Pneumatics failure
During building and the competition, we had a habit of inflating the pneumatics tank to above its maximum rated pressure to try and fit more air in it. We did not realize that this would lead to a failure of the bike pump valve, such that it would not hold air anymore. So any mechanism involving pneumatics was off the table, such as our triball launcher. We had to change our strategy at this point. 

Later we had solved this problem by sealing the end of the tank with the bike pump valve, and instead using the tubes themselves to connect to the small end of the bike pump.
### `JiggleIt` function

### Stuck on a triball

### PROS
> Written by Aseer

At this time, we were exploring new technologies. I was more experienced in C than Python, so I decided to explore different ways to write robot code. VEX offers native C++ support, but not C support, and there is a lack of documentation about the different methods, instead relying on Intellisense for showing the right methods. PROS offers C support in a simple package. OkapiLib makes writing autonomous code easy, but we never used it.

As I was reading the tutorial, I realized that the C code was wrong, as it was using C++ syntax, so I submitted a pull request to fix it which was accepted.

# Allen 2.0


## Design

### Offensive playstyle

## Programming

# Allen 2.1

## Design

### Switch from iron to aluminium

### Pneumatic stake grabber

### Intake mechanism

## Programming

### Version control
Before, our version control system was downloading the latest version of the project, editing it, and posting it on the list. This worked fine for a while, but became annoying, the process of downloading, opening, saving, and uploading. This was the problem with VEXCode online projects, as they could only be moved around through a format which is not version control friendly.

Our solution was to start using VS Code for projects, which allows us to version control Python code on `git`. There was a bit of a learning curve, but with previous experience in `git`, you realize that for simple projects, you only need a handful of commands for everything (`push`, `pull`, `commit`, `add`), and when something else happens, you can just search up the commands. The `git` capabilities of VS Code streamline this process even more.

### Switch to Python
The switch to Python happened because of the control curve and the version control. Using Python rather than blocks also seemed much more practical, as it is often easier to read than disparate stacks of blocks, and it is much easier to use common mathematical operations needed for the control system. Python code is also much easier to document. We were really using blocks as a temporary solution.

### Control curve
Usually, the speed of the motors is proportional to the position of the joystick. However, this solution can be improved. For one, when driving on the field, there is no point in having a sort of in-between speed that is highly precise. Instead, you want more control on low speeds, and more control on high speeds. You still want to provide the full space of speeds, so you put a steep slope in between these two regimes. I thought about what function fits this criteria, and I thought of the logistic curve.

The logistic curve is defined by:

$L\left(x\right)=\frac{M}{1+e^{-k\left(x-a\right)}}$.

Given the values $M = 100$, $k = 0.15$, and $a = 50$, we get this graph:
![Graph showing the logistic curve](logistic_curve_usual.png)

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

# Barron
While the team was iterating over the design of Allen 2.1, we wanted to explore a different design for the robot, and we also wanted to test software while the others were busy with the subsystems on the other robot. Barron was designed to cover a large footprint, with an aluminium-only chasis. It was impractically fast at full speed, so the speed and turning was limited in software.

## Design
Barron was designed to be a sort of opposite to Allen. Allen is heavy and has a low centre of mass, while Barron is light. Barron is very wide, barely within the size limit, while Allen has a compact form, focusing on height instead.

## Programming


# Mathematical techniques

## Motor curve

## Drivetrain calculator spreadsheet
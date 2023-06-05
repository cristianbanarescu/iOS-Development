# Size Classes Demo

## Purpose

This little iOS project was created in order to demonstrate how iOS Size classes work. The project just shows 2 rectangular views (placed side by side) that have different widths and heights based on different size classes.

## Size Classes - nice to know:

* They are concepts used by developers to **adapt the UI of an app to different screen sizes and device orientations**
* Part of AutoLayout
* There are 2 size classes and both can be used for the width(horizontal) and height(vertical) axes of a device:
    - **Regular** -> to be used when you have **lots** of available space for your UI; mainly used for width
    - **Compact** -> to be used when you have **limited** space available for your UI; mainly used for height 
* iPads have both regular widht and height size class so a change in an iPad's orientation won't change the size class.

Examples: 

- a fullscreen app on an iPad will have a Regular width and height size class for any device and orientation
- an iPad with Split Screen or Slide Over ON can have a regular and compact width size class 
- you can create constraints in Interface Builder and make them 'available' only for a specific size class
- you can arrange 2 views side by side in a regular width size class and have them one on top of the other one in a compact width size class
- have a different font size when using an iPad, compared to when using an iPhone
- add aditional UI elements only when on iPad

## Useful links

* https://www.youtube.com/watch?v=Uc8IJz6zsME&ab_channel=Kodeco
* https://useyourloaf.com/blog/size-classes/
* https://www.hackingwithswift.com/example-code/uikit/what-are-size-classes
* https://medium.com/@craiggrummitt/size-classes-in-interface-builder-in-xcode-8-74f20a541195
* https://medium.com/@furkan.vijapura/iphone-size-classes-2a50b4c9872c

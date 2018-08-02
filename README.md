# Test task, which includes: JSON parsing, search for a minimum route between two points, draw the route on the map
================================

## Data

In the attachment JSON (`a1s.rtf`) and JPG-picture (`image001.jpg`).
JSON provides a graph of roads and other information.
The JPG picture is used as the background image of the map.
(There are no limitations on supported versions of ios: it is desirable to use swift as the programming language.)

## The essence of the problem:

We need to develop a demo application and send us the source of the finished project.
A map (JPG picture in the attachment) should be displayed on the screen.
* When tapping on the map, the starting point of the route is selected. 
* At the second tap, the final point on the map is selected, and the shortest route from the initial to the final point is laid. 
* The next tap resets the selected points and route.


## Supported Platforms
- iOS

## Screenshots
![output](https://user-images.githubusercontent.com/27812408/43611565-376f213c-96b2-11e8-893c-98e33a8e72b9.gif)

## Directed graph

Directed graph was used

![img_002](https://user-images.githubusercontent.com/27812408/43416140-277065d0-9440-11e8-8811-44176f33e2e3.png)

It means you can get from the vertex A to the vertex B, but you can not get back in the same way

## Alerts

When working with app you can get 4 type of alerts:

The route can not be built from start point.

![img_003](https://user-images.githubusercontent.com/27812408/43416376-c14592de-9440-11e8-8bd2-c8a53b328114.png)

The route can not be built to end point.

![img_001](https://user-images.githubusercontent.com/27812408/43416434-e5b673ae-9440-11e8-9e74-51fdad3fa6b8.png)

The start and end points of the route are the same: select another end point.

The start and end points of the route are not linked: select another end point.

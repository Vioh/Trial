# Hazard sensing platform

## Project description

The main idea of the project is to build a connected sensor platform that can be attached to vehicles moving around in an open-space environment and collect data about the environment and push it to the cloud. In this project, we choose to focus mainly on measurements that can tell us if the environment is hazardous or not.
For demonstration purposes, our plan is to build a small board representing the environment in which the vehicles can drive in, and collect data in real time in order to show the measurements in a map. Using the data collected, we will also create an app that can automatically warn individuals if they are entering a zone that is considered to be hazardous.
The sensing platform is simply a box containing all sensors that can be used to collect data from the environment.
With the goal of having at least 5 distinct sensors, we will focus on the following measurements:

![Alt text](./resources/platform_architecture.svg)

## Prerequisites

Both ``docker`` and ``docker-compose`` must be installed to test the project.

## Storage

First, change directory to the ``storage`` folder:
```bash
cd ./storage
```

To install all dependencies:
```bash
setup=true docker-compose up
```

To run all containers in development mode:
```bash
docker-compose up
```

To run all containers in detached mode:
```bash
docker-compose -d up
```

To rebuild all containers:
```bash
docker-compose up --build
```

HazBox



* Dust
* Sound
* Ultra-violet radiation
* Humidity
* Temperature
* CO2 and VOC levels
To "simulate" the environment, we are planning to build a small board (2m^2) in which the vehicles can drive in. In this environment, we will simulate different hazardous scenarios. For example, UV lights can be used to simulate increase in UV radiation levels, etc.







# Hazard sensing platform

This project is created for the [Ariot 2020 Hackathon](https://ariot.no/). Our team consists of 6 *hazardous coders* from [Aptiv Gothenburg Sweden](https://www.aptiv.com/), who want to shape the future of mobility and to make the world a less hazardous place.

Team members:
* [Annie Lantz](https://www.linkedin.com/in/annie-lantz/)
* [Hai Dinh](https://www.linkedin.com/in/hai-dinh-sy/)
* [Ioannis Gkikas](https://www.linkedin.com/in/ioannis-gkikas-0b5a6010b/)
* [Johan Johansson](https://www.linkedin.com/in/johan-johansson-0944b6130/)
* [Simon Widlund](https://www.linkedin.com/in/simonwidlund/)
* [Spyros Gryparis](https://www.linkedin.com/in/spyros-gryparis-28501269/)

## Project description

As the world becomes increasingly more hazardous due to all kinds of pollutions, corona virus outbreak, and possible zombie apocalypses, we need a system that can collect data in order quickly detect hazardous areas, such that we can then geo-fence people from enter these areas, thus improving the health of the general population.

Taking advantage of the recent advances in the mobility technology (including the soon-to-be-available 5G network), our main idea is to build a connected hazard sensing platform, that can be mounted to any moving vehicles, in order to collect data about the environments and then push it to the cloud.

The collected data will be used to show a real-time map of measurements on a web dashboard. We will also create a mobile app that can be used to geo-fence people from entering areas that we consider to be dangerous.

Note that the collected data can also be used by scientists and governments, in order to come up with better environmental policies.

## Platform architecture

![Alt text](./resources/platform_architecture.svg)

**Deployment Strategy**: For many of the components listed below, Docker will be used to make it easier for us to deploy our solution.

**HazBox**: This is a box containing a set of sensors used for detecting hazardous areas. The Hazbox is designed to easily be mounted on top of a vehicle, and should also be able to protect itself from things like rain. HazBox will consist of the following sensors:
* Dust
* Sound
* Ultra-violet radiation
* Humidity
* Temperature
* CO2 and VOC (volatile organic compound)

**MQTT Broker**: Responsible for establishing a simple but secure connection, to allow the HazBox to reliably push data to the cloud. We will use an online instance of Mosquitto MQTT broker that can support TLS/SSL communication for extra layer of security.

**Data Processing**: Responsible for getting data from the MQTT broker, processing it (e.g., by performing unit conversions, etc.), and then saving the data to the database.

**Database**: A simple MongoDB instance, with authentication enabled, for saving all data.

**Data API**: Responsible for fetching data from the database to serve to the frontend. This will consist of a standard REST request-response api, as well as a streaming api to allow for real-time updates. The API will also contains logic for deciding whether an area is considered to be dangerous or not, mostly for geo-fencing purposes.

**Web Dashboard**: Responsible for showing live data on a heat map. The dashboard can also be extended to show various trend lines, and many other things.

**Geo-fencing Mobile App**: Here, we plan to develop a simple native Android app that can geo-fence people when they enter a dangerous area.

## Project scope

TODO


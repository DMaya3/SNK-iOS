# SNK-iOS

## Description
An application about Shingeki No Kyojin. In this application you can see and know everything about the anime/manga. From the characters (name, age, if they are titans or not...) to the episodes in which they appear (name, episode number, filtered by seasons...).

The app is made with the MVVM architecture as it makes it scalable. It use Core Data framework to persistent data and it has Unit Test and accessibility.

## How is done?

## Model
Inside the model is everything about app logic. Here is the repository that will be in charge for calling the service to get data from an online api (https://api.attackontitanapi.com) from where get data. In this case the app only get data about characters and episodes.

### Core Data

Those data are decoded in JSON formatter and saved in device by Core Data framework. To do this I had to create a data model inside my project with the needed entities and their properties. After that, I created their respective classes to decode data from api to core data entities. Futher more, I had to create a core data provider to save data in context and load from that context. In that provider it checks if the object exists to void call API in that case and duplicate data. 

In Core Data model when someone create a property inside an entity, that property has a determinated number of types. So if you need create a property of a specific type, core data gives you a type called "Transformable". I´ve needed some transformable properties and I´ve had to create their respectives transformer class to add them to the app. That way allows me have a specific object property without error or warning.

### Repository

I´ve prepared the calls to the service here. This repository has a generic method to call the api and get data from API depending of endpoint it receive from parameter. That way allows have a cleaner code and easy to read and understand. It has a generic method to request and decode JSON where it handle errors in case it has. After that I´ve created a specific repository for the app where it´s prepared the call with all it parameters like path, method, headers and body. It has two methods: one for get characters and other to get episodes. Each method call the same generic method.

### UseCases

Those methods created in app´s repository are called in use cases. Each entity (characters and episodes) has it own use case. The use case connect to the repository to call the service asyncronously.

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

## View Model
In the app´s view model it fetchs data by publishers and get it by suscribers. When it goes to fetch data check first if the object exists. In that case it get data from Core Data otherwise fetch data from use case instantiated by dependencies and continue to the api to get data. After that populate core data entities by a method created in viewModel which call a method in Core Data provider.

## View
The view of this app is divided in some views.

### Home View
The principal view. The first screen that the user see when open the app. This screen has a title, description, two cards sections and on link at the end to get more info about manga/anime. Those sections are characters and episodes and each section navigate to their respectives screens. Futher more, the image cards automatic change each 3 seconds. It has a menu too. That menu has 4 options: Home, Characters, Episodes and Settings. It funcionality is told later.

The link at the end of the screen open a sheet displaying a webview (https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki).

### Home View Screenshot

https://github.com/user-attachments/assets/c0a1bf9e-c802-41e2-b11d-4f80cd9925bb




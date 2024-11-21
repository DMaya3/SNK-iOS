# SNK-iOS

## Description
An application about Shingeki No Kyojin. In this application you can see and know everything about the anime/manga. From the characters (name, age, if they are titans or not...) to the episodes in which they appear (name, episode number, filtered by seasons...).

## How is done?
The app calls an online api (https://api.attackontitanapi.com) from where get data. In this case the app only get data about characters and episodes.

Those data are decoded in JSON formatter and saved in device by Core Data framework. To do this I had to create a data model inside my project with the needed entities and their properties. After that, I created their respective classes to decode data from api to core data entities. Futher more, I had to create a core data provider to save data in context and load from that context. In that provider it checks if the object exists to void call API in that case and duplicate data. 

In Core Data model when someone create a property inside an entity, that property has a determinated number of types. So if you need create a property of a specific type, core data gives you a type called "Transformable". I´ve needed some transformable properties and I´ve had to create their respectives transformer class to add them to the app. That way allows me have a specific object property without error or warning.

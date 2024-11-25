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
The principal view. The first screen that the user see when open the app. This screen has a title, description, two cards sections and a link at the end to get more info about manga/anime. Those sections are characters and episodes and each section navigate to their respectives screens. Futher more, the image cards automatic change each 3 seconds. It has a menu too. That menu has 4 options: Home, Characters, Episodes and Settings. It funcionality is told later.

The link at the end of the screen open a sheet displaying a webview (https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki).

### Home View Screenshot

https://github.com/user-attachments/assets/1a80ac03-4df1-4ba8-bc3b-ac3eddfe20f0

### Characters View

When the user tap in characters card section it navigates to a list of characters. This list has all characters of manga/anime with some info like name, age, status (alive, deceassed or unknown) and image. Each item navigates to a detail screen. In that screen the user can see more info about the character: residence, recognized species, alias, roles, family and episodes (carousel) and each item of family and episodes carousel navigate to it respective detail screen. Futher more, that screen has a back button to back to previous screen and other button to navigate to Home screen.

https://github.com/user-attachments/assets/2253e7cd-1a9b-4f00-b833-de5073639e77

### Episodes View

When the user tap in episodes card section it navigates to a list of episodes. This list has all episodes of anime with some info like name, number episode and image. Each item navigates to a detail screen where the user can see a list of characters which participate in that episode. Each item of that list of characters navigates to that character detail screen.

https://github.com/user-attachments/assets/a9ee739f-01dd-4e34-8c97-7ef0c17658fa

### Settings View

The app has a settings screen where the user can set the language and the appearance (dark mode). These preferences are saved in the device what allows to the user maintain his preference when the user open the app again.

https://github.com/user-attachments/assets/49735bbf-552d-4752-afe7-7984f03d7379

### Menu View

As discussed in the section on Home View I´m going to tell you about menu view and it options. When the user tap in the top trailing button it opens a lateral menu with four options: Home, Characters, Episodes and Settings. Each option of this menu navigates to it respective screen. To close the menu the user can tap in the close button (top trealling of menu) or in anyplace of the screen.

https://github.com/user-attachments/assets/ab6eea06-41dc-4605-963b-81747665855e

### Filter View

Both characters list and episodes list has a floating button bottom trailing which navigates to Filter view. This view allows the user search by name and status (in case the user wants filter characters) or by name and seasons (in case the user wants filter episodes). The filter button in both lists change the image and action when is filtered. When is filtered, the same floating button clean filters and it get back the original list.

https://github.com/user-attachments/assets/9e3435c2-3e40-4ae6-806e-0fd9b4911c72

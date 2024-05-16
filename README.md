#TODO FullStack Application

This is experiment project after learnt GO Lang for Backend development. Included CRUD operations for Todo system. Mobile application is using Flutter for IOS and Android development.


⚠️_**Code are might not be perfect for flutter project coz it's took 1 day to finish**_⚠️

_Project Instructions_

Project has 2 folders, one is for server using Go lang to generate API for Frondend. Another one is Flutter for IOS and Android.

## Screenshots

[<img src="./arts/screenshot1.png" width="400"/>](web.png)
[<img src="./arts/screenshot2.png" width="400"/>](web.png)



##  Tech Stacks For Server
  
*   Gin for handle Http transaction [Link](https://github.com/gin-gonic/gin) 
*   Gorm for ORM database [Link](https://gorm.io)
*   JWT for handle Authentication [Link](https://github.com/golang-jwt/jwt)
*   MVC patteren 
*   etc. 

##  Tech Stacks For Mobile

* http for networking [Link](https://pub.dev/packages/http)
* Jsonserializable for json builder [Link](https://pub.dev/packages/json_serializable)
* Freezed for support rich feature for data model class [Link](https://pub.dev/packages/freezed)
* GetIt for dependency [Link](https://pub.dev/packages/get_it)
* Go Router for navigation [Link](https://pub.dev/packages/go_router)
* etc.

## Instruction To Run

### Server

1. Install MySql in your mechine
2.  Clone repository  
3. In terminal -> `cd server` enter `go mod tidy` wait to install depedencies.
4. After that `go run .` then the server will listen on port 3333, in localhost `http://localhost:3333`

### Mobile

1. Install Flutter and setup Flutter SDK configuration
2. Clone repository and open the app folder
3. `Flutter pug get`
4. `Flutter run`


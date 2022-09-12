# Employee-Management-System

This application demonstrates an employee management system for a food delivery company. It handles functionalities like creating employees and admin with authentication and authorization, admin assigning tasks based on the employee roles, and employees can view a list of restaurant orders coming to the application and list tasks they are assigned to.

# Technologies Used:
	
- Flutter for web (frontend)
  - Plugins/Libraries:
    - provider for state management
	- hive for local storage
	- fluro for routing

- Node with typescript(backend)
  - Plugins/Libraries:
    - express for api development 
	- twilion for OTP(verification)
	- mysql for storing data
	- JWT for tokenization and flutter_secure_storage to encrypt key value


# Configure .env file for your project(server) 

```ACCESS_TOKEN_SECRET = ****
REFRESH_TOKEN_SECRET = ****

TWILIO_ACCOUNT_SID = ****
TWILIO_AUTH_TOKEN = ****

TWILIO_SERVICE_SID = ****

```


# Configure .env file for your project(frontend) 


```EMS_ADMIN_BOX = ****
ENCRIPTION_ADMINKEY_STORAGE = ****

EMS_USER_BOX = ****
ENCRIPTION_USERKEY_STORAGE = ****

EMS_USER_TYPE_BOX = ****
EMS_USER_ROLE_ID = ****

```

## Installing and start the server

- move to backend directory : <cd backend>

- If node is not installed then Install [node] (https://nodejs.org/en/download/)
- Run the following command to load all the module dependencies for this app:

  ### `npm install` or `yarn install`

- In my project I used nodemon for the project to run in developement or you can change script in package.Json based on your preference:

  ### `nodemon start` or 

Open [http://localhost:<yourEnvPort>](http://localhost:<yourEnvPort>) to view it in the browser.



## Installing and start the frontend(Ui)

- move to frontend directory : <cd frontend>

  ### `flutter pub get`

- to start and run the flutter project

  ### `flutter run`




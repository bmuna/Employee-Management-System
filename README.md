# Employee-Management-System

This application demonstrates an employee management system for a food delivery company. It handles functionalities like creating employees and admin with authentication and authorization, admin assigning tasks based on the employee roles, and employees can view a list of restaurant orders coming to the application and list tasks they are assigned to.

## Technologies Used:
	
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


## Configure .env file for your project(server) 

```ACCESS_TOKEN_SECRET = ****
REFRESH_TOKEN_SECRET = ****

TWILIO_ACCOUNT_SID = ****
TWILIO_AUTH_TOKEN = ****

TWILIO_SERVICE_SID = ****

```


## Configure .env file for your project(frontend) 


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

## Screenshot

![welcome](https://user-images.githubusercontent.com/38354323/189662153-fb46c976-5985-473c-8d5a-69655eef828e.JPG)	
![login-admin-error-handling](https://user-images.githubusercontent.com/38354323/189662132-e175dc38-7fa0-4a9b-89e4-104450efa2ec.JPG)
![admin-loadin](https://user-images.githubusercontent.com/38354323/189662194-aa3b0735-dff0-40dc-a029-a37d6aea0356.JPG)	
![employee-login](https://user-images.githubusercontent.com/38354323/189662125-28f27e43-cf60-4988-ba07-6f818dc63ce2.JPG)
![otp](https://user-images.githubusercontent.com/38354323/189662138-06d7f820-8f78-4dd3-81d6-e03ec161e4d7.JPG)	
![admin-dashboard](https://user-images.githubusercontent.com/38354323/189662162-02ee3ab2-8d72-4eae-8215-1cf69e703727.JPG)
![employee-dashboard](https://user-images.githubusercontent.com/38354323/189662111-57825404-1ad3-438b-864b-32c24d2b1f2b.JPG)	
![admin-employee](https://user-images.githubusercontent.com/38354323/189662176-b911b62d-6968-4b4b-a62b-aca2044f50e3.JPG)	
![admin-role](https://user-images.githubusercontent.com/38354323/189662090-6c6468ec-3b03-4ea5-bedd-d5756824e194.JPG)
![admin-task](https://user-images.githubusercontent.com/38354323/189662104-ca306360-dec7-47be-9056-040c543419ad.JPG)
![admin-logout](https://user-images.githubusercontent.com/38354323/189662202-059a4b08-49c6-4584-ba2e-e83673ddac91.JPG)




import dotenv from 'dotenv';

dotenv.config();

const MYSQL_HOST = process.env.MYSQL_HOST;
const MYSQL_DATABASE = process.env.MYSQL_DATABASE;
const MYSQL_USER = process.env.MYSQL_USER;
const MYSQL_PASSWORD = process.env.MYSQL_PASSWORD;
const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;
const TWILIO_ACCOUNT_SID = process.env.TWILIO_ACCOUNT_SID;
const TWILIO_AUTH_TOKEN = process.env.TWILIO_AUTH_TOKEN;  
const TWILIO_SERVICE_SID = process.env.TWILIO_SERVICE_SID;  

const MYSQL  ={  
	host: MYSQL_HOST,
	database: MYSQL_DATABASE,
	user: MYSQL_USER,
	password: MYSQL_PASSWORD

}

const SERVER_HOSTNAME = process.env.SERVER_HOSTNAME
const SERVER_PORT = process.env.SERVER_PORT

const SERVER = {
	hostname: SERVER_HOSTNAME,
	port: SERVER_PORT,
	tokensecret: ACCESS_TOKEN_SECRET,
}

const TWILIO = {
	accountId: TWILIO_ACCOUNT_SID,
	authToken: TWILIO_AUTH_TOKEN,
	serviceSID : TWILIO_SERVICE_SID
}

const config = {
	mysql: MYSQL,
	server: SERVER,
	twilio: TWILIO
}

export default config;
import config from '../config/config';
import mysql from 'mysql';
import dotenv from 'dotenv';



dotenv.config();


const params = {
    user: config.mysql.user,
    password: config.mysql.password,
    host: config.mysql.host,
    database: config.mysql.database
};

const Connect = async () => 
	new Promise<mysql.Connection>((resolve, reject) => {
        const connection = mysql.createConnection(params);

        connection.connect((error) => {
            if (error) {
                reject(error);
                return;
            }

            resolve(connection);
        });
    });


const Query = async <T>(connection: mysql.Connection, query: string) =>
    new Promise<T>((resolve, reject) => {
        connection.query(query, connection, (error, result) => {
            if (error) {
                reject(error);
                return;
            }

            resolve(result);
            connection.end();
        });
    });

export { Connect, Query };

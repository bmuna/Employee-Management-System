import {NextFunction, Request, Response} from 'express';
import {Connect, Query} from '../config/mysql';
import logging from '../config/logging';
import IMySQLResult from '../interfaces/result';
import ITask from '../interfaces/task';
import IUser from '../interfaces/users';



const NAMESPACE = 'Admin ';

const addUsers = (req: Request, res: Response, next: NextFunction) => {
	let { full_name, phone_number, email, role_id } = req.body;
	const user_type = "employee";
	const dateTime = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '')
      
	let query = `INSERT INTO users (full_name, email, role_id, phone_number, user_type, createdAt, updatedAt) VALUES ("${full_name}", "${email}", "${role_id}", "${phone_number}", "${user_type}", "${dateTime}", "${dateTime}")`;

	Connect()
	.then((connection) => {
		Query<IMySQLResult>(connection, query)
			.then((users) => {
				logging.info(NAMESPACE, `Employee added successfully.`);
				return res.status(201).json({
				code: 201,
				message: 'Employee added successfully.',
				users,
			});
			})
			.catch((error) => {
				logging.error(NAMESPACE, error.message, error);
				return res.status(500).json({
					code: 500,
					message: error.message,
					error
				});
			});
	})
	.catch((error) => {
		logging.error(NAMESPACE, error.message, error);

		return res.status(500).json({
			code: 500,
			message: error.message,
			error
		});
	});

}



const addRole = (req: Request, res: Response, next: NextFunction) => {
	let { role } = req.body;

	let query = `INSERT INTO roles (role) VALUES ("${role}")`;
	Connect()
	.then((connection) => {
		Query<IMySQLResult>(connection, query)
			.then((result) => {
				logging.info(NAMESPACE, `Admin adding roles`);
				return res.status(201).json({
					code: 201,
					message: "admin successfully added a role",
					result
				});
				
			})
			.catch((error) => {
				logging.error(NAMESPACE, error.message, error);

				return res.status(500).json({
					code: 500,
					message: error.message,
					error
				});
			});
	})
	.catch((error) => {
		logging.error(NAMESPACE, error.message, error);

		return res.status(500).json({	
			code: 500,
			message: error.message,
			error
		});
	});
}

const addTask = (req: Request, res: Response, next: NextFunction) => {
	let { tasks } = req.body;


	let sql = tasks.map((val: ITask) => `("${val.task}", "${val.role_id}")`)
    let query = "INSERT INTO tasks (task, role_id) VALUES " + sql
	

	Connect()
	.then((connection) => {
		Query<IMySQLResult>(connection, query)
			.then((result) => {
				logging.info(NAMESPACE, `Admin adding task id of ${result.insertId}`);
				return res.status(201).json({
					code: 201,
					message: "admin successfully added tasks",
					result
				});
			})
			.catch((error) => {
				logging.error(NAMESPACE, error.message, error);
				return res.status(500).json({
					code: 500,
					message: error.message,
					error
				});
			});
		
	})
	.catch((error) => {
		logging.error(NAMESPACE, error.message, error);

		return res.status(500).json({
			code: 500,
			message: error.message,
			error
		});
	});

	
}






const getUsersWithRoles = (req: Request, res: Response, next: NextFunction) => {

	let query = `SELECT role_id, full_name, email, phone_number, user_type, createdAt, updatedAt, role FROM users
	INNER JOIN Roles ON roles.id = users.role_id`

	Connect()
	.then((connection) => {
		Query<IUser[]>(connection, query)
			.then((result) => {
				logging.info(NAMESPACE, `Admin getting employee with thie roles}`);
				return res.status(201).json({
					code: 201,
					result
				});
			})
			.catch((error) => {
				logging.error(NAMESPACE, error.message, error);
				return res.status(500).json({
					code: 500,
					message: error.message,
					error
				});
			});
		
	})
	.catch((error) => {
		logging.error(NAMESPACE, error.message, error);

		return res.status(500).json({
			code: 500,
			message: error.message,
			error
		});
	});

	
}

const getListOfRole = (req: Request, res: Response, next: NextFunction) => {
	let query = `SELECT * FROM Roles`
	    Connect().then((connection) => {
		Query(connection, query)
			.then((result) => {	
					logging.info(NAMESPACE, `getting list of roles`);
					return res.status(201).json({
						code: 201,
						result
						})
			
			}).catch((error) => {
				logging.error(NAMESPACE, error.message, error);
					return res.status(500).json({
							code: 500,
							message:  error.message ,
							error
						});
					});	
				})
        .catch((error) => {
            logging.error(NAMESPACE, error.message, error);
                return res.status(500).json({
					code: 500,
                    message: error.message,
                    error
             });
     });

}


const getUsers = (req: Request, res: Response, next: NextFunction) => {
	

	let query = `SELECT id, role_id, full_name, email, phone_number, user_type, createdAt, updatedAt FROM Users WHERE user_type = 'employee'`;
    Connect().then((connection) => {
		Query<IUser[]>(connection, query)
			.then((users) => {	
			
					logging.info(NAMESPACE, `getting users data`);
					return res.status(201).json({
						code: 201,
						users
						})
			
			}).catch((error) => {
				logging.error(NAMESPACE, error.message, error);
					return res.status(500).json({
							code: 500,
							message:  error.message ,
							error
						});
					});	
				})
        .catch((error) => {
            logging.error(NAMESPACE, error.message, error);
                return res.status(500).json({
					code: 500,
                    message: error.message,
                    error
             });
     });

}


export default { addUsers, addTask, getUsers, addRole, getUsersWithRoles, getListOfRole}
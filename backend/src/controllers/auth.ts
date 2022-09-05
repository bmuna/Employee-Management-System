import {NextFunction, Request, Response} from 'express';
import logging from '../config/logging';
import Twilio from 'twilio';
import config from '../config/config'
import bcrypt from 'bcryptjs';
import {Connect, Query} from '../config/mysql';
import {signJWT} from '../functions/signJWT';
import IUser from '../interfaces/users';


const NAMESPACE = 'User';

const signupAdmin = (req: Request, res: Response, next: NextFunction) => {
	let { email, password } = req.body;
	console.log(email, password)
	var salt = bcrypt.genSaltSync(12);
	const user_type = "admin";
	const dateTime = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '')


	bcrypt.hash(password, salt, (error, hashPassword) => {
        if (error) {
            return res.status(401).json({
				code: 401,
                message: error.message,
                error: error
            });
        }

        let query = `INSERT INTO users (email, password, user_type, createdAt, updatedAt) VALUES ("${email}", "${hashPassword}", "${user_type}", "${dateTime}", "${dateTime}")`;
		
        Connect()
            .then((connection) => {
                Query(connection, query)
                    .then((result) => {
                        logging.info(NAMESPACE, `User inserted.`);

                        return res.status(201).json({
							code: 201,
							message: "Admin user successfully inserted",
							result
						})
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
    });
}



const loginAdmin = (req: Request, res: Response, next: NextFunction) => {
	let { email, password } = req.body;

	console.log('email', email, password)

	let query = `SELECT * FROM users WHERE email = '${email}'`;

	Connect().then((connection) => {
		Query<IUser[]>(connection, query)
		.then((users) => {
			if (email == users[0].email) {
			let checkPass = bcrypt.compareSync(password, users[0].password) ;
				  if (checkPass) {
					signJWT(users[0], (_error, token) => {
						if (_error) {
							return res.status(401).json({
								code: 401,

								message: 'Unable to Sign JWT',
								error: _error
							});
						} else if (token) {
							return res.status(201).json({
								code: 201,
								message: 'Auth Successful',
								token,
								users,
						});
					}
					});
				}else {
					console.log(users[0].password);
					return res.status(401).json({
						code: 401,
						message: 'Password Mismatch'
					});
				}
			}else{
				logging.info(NAMESPACE, `user email missmatch`);
				return res.status(401).json({
					code: 401,
					message: 'email missmatch'
				});
			}
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
	// .catch((error) => {
	// 	logging.error(NAMESPACE, error.message, error);
	// 	return res.status(500).json({
	// 		message: error.message,
	// 		error
	// 	});
	// });
};



			
const sendOTP = (req: Request, res: Response, next: NextFunction) => {
	let { phone_number } = req.body;

	const client = Twilio(config.twilio.accountId, config.twilio.authToken);
	client.verify.v2.services(config.twilio.serviceSID!)
	.verifications
	.create({to: phone_number, channel: 'sms'})
	.then((verification) => {
		logging.info(NAMESPACE, `User send notification with ${verification.sid}`);
		return res.status(201).json({
			code: 201,
			message: 'successfuly sent notification',
		});
	}).catch((error) => {
		logging.error(NAMESPACE, error.message, error);
		return res.status(500).json({
			code: 500,
			message: error.message,
			error
		});
	  });
	
}

const verifyOTP = (req: Request, res: Response, next: NextFunction) => {
	let { phone_number, otp_code } = req.body;

	const client = Twilio(config.twilio.accountId, config.twilio.authToken);
	client.verify.v2.services(config.twilio.serviceSID!)
	.verificationChecks
	.create({to: phone_number, code: otp_code})
	.then((verification_check ) => {
		logging.info(NAMESPACE, `User verified notification with ${verification_check.sid}`);
		let query = `SELECT * FROM Users WHERE phone_number = '${phone_number}'`;
		Connect().then((connection) => {
			Query<IUser[]>(connection, query)
			.then((users) => {
				console.log("users", users);
						signJWT(users[0], (_error, token) => {
							if (_error) {
								return res.status(401).json({
									code: 401,
									message: 'Unable to Sign JWT',
									error: _error
								});
							} else if (token) {
							console.log(users[0].id);
							return res.status(201).json({
								code:201,
								message: 'Auth Successful',
								token,
								users
						});
							}
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
	
	}).catch((error) => {
		logging.error(NAMESPACE, error.message, error);
		return res.status(400).json({
			code: 400,
			message: error.message,
			error
		});
	  });
}

const checkExistEmployee = (req: Request, res: Response, next: NextFunction) => {
	let { phone_number} = req.body;

	let query = `SELECT * FROM Users WHERE phone_number = '${phone_number}'`;
    Connect().then((connection) => {
		Query<IUser[]>(connection, query)
			.then((users) => {	
			
					logging.info(NAMESPACE, `User with ${users[0].phone_number} is already registered`);
					return res.status(201).json({
							code: 201,
							message:  `user is already registered`,
						})
			
			}).catch((error) => {
				logging.error(NAMESPACE, error.message, error);
					return res.status(404).json({
							code: 404,
							message:  `User doesn't exist`,
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





export default { signupAdmin, loginAdmin, sendOTP, checkExistEmployee, verifyOTP}

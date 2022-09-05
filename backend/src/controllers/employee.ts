import {NextFunction, Request, Response} from 'express';
import logging from '../config/logging';
import { Connect, Query } from '../config/mysql';

const NAMESPACE = 'Employee ';

const getTasks = (req: Request, res: Response, next: NextFunction) => {
	let role_id = req.params.id;

	let query =	 `SELECT task FROM Tasks WHERE role_id = ${role_id}`


    Connect().then((connection) => {
		Query(connection, query)
			.then((results: any) => {	
				console.log('results', results)
				logging.info(NAMESPACE, `getting tasks for employee of ${role_id} `);
						return res.status(201).json({
						code: 201,
						results,
				})
			}).catch((error) => {
				logging.error(NAMESPACE, error.message, error);
					return res.status(500).json({
						    code: 500,
							message:  `User doesn't exist`,
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



export default { getTasks}
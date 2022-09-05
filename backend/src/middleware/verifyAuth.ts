import jwt  from 'jsonwebtoken';
import config from '../config/config';
import logging from '../config/logging';
import { Request, Response, NextFunction } from 'express';
import IDecodeTokenUser from '../interfaces/token_decode';



const NAMESPACE = 'Auth';

const verifyAuth = (userType: string ) => {
	return ( req: Request, res: Response, next: NextFunction) => {

    logging.info(NAMESPACE, 'Validating token');

    let token = req.headers.authorization?.split(' ')[1];
	
    if (token) {
        jwt.verify(token, config.server.tokensecret!, (error, decoded) => {
            if (error) {
                return res.status(404).json({
					error:"Invalid Token",
                    message: error,
                });
            } else {		
				var decodedData =  <IDecodeTokenUser>(decoded);
				if(userType != decodedData.user.user_type){
					return res.status(401).json({
						message: 'Unauthorized'
					});
				}
				else{
					next();
				}
            }
        });
    } else {
        return res.status(401).json({
            message: 'Unauthorized'
        });
    }
	}
};

export default verifyAuth;

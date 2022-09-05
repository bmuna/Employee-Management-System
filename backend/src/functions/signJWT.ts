import jwt from 'jsonwebtoken';
import logging from '../config/logging';
import config from '../config/config';
import IUser from '../interfaces/users';



const NAMESPACE = "Auth"

const signJWT = (user: IUser, callback: (error: Error | null, token: string | null) => void): void => {
	logging.info(NAMESPACE, `Attempting to sign token for ${user.id}`);
    console.log('user:', user);
	try{
	jwt.sign(
		{
			user: user
		}, 
		config.server.tokensecret!,{},
		(error, token) => {
			if (error) {
				callback(error, null);
			} else if (token) {
				callback(null, token);
			}
		})
	}  catch (error: any) {
        logging.error(NAMESPACE, error, error);
        callback(error, null);
    }

	
}



export  {signJWT};

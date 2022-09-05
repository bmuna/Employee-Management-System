import express from 'express';
import controller from '../controllers/auth';

const router = express.Router();

router.post('/signup_admin', controller.signupAdmin);
router.post('/login_admin', controller.loginAdmin);
router.post('/send_otp', controller.sendOTP);
router.post('/verify_otp', controller.verifyOTP);
router.post('/check_exist_employee', controller.checkExistEmployee);


export default router;

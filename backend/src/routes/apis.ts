import express from 'express';
import authRoute from './auth'
import adminRoute from './admin'
import employeeRoute from './employee'
import verifyAuth from '../middleware/verifyAuth';


const router = express.Router();

router.use("/auth", authRoute);
router.use("/admin",verifyAuth("admin"), adminRoute);
router.use("/employee", verifyAuth("employee"), employeeRoute);



export default router;

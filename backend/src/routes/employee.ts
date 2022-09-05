import express from 'express';
import controller from '../controllers/employee';

const router = express.Router();

router.get('/get_tasks/:id', controller.getTasks);

export default router;

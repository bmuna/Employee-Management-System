import express from 'express';
import controller from '../controllers/admin';

const router = express.Router();

router.post('/add_users', controller.addUsers);
router.post('/add_role', controller.addRole);
router.post('/add_task', controller.addTask);
router.get('/get_users', controller.getUsers);
router.get('/get_list_role', controller.getListOfRole);
router.get('/get_users_with_roles', controller.getUsersWithRoles);



export default router;

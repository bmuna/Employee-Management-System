import http from 'http';
import express from 'express';
import cors from 'cors';

import bodyParser from 'body-parser';
import logging from './config/logging';
import config from './config/config';
import apiRoute from './routes/apis';

const NAMESPACE = 'server';
const router = express();


router.use(cors());

router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());


router.use('/ems/api/v1', apiRoute);


router.listen(config.server.port, () => 
logging.info(NAMESPACE, `Server running on ${config.server.hostname}:${config.server.port}`)
)
// src/config/database.ts (CREALO vos)
import { Sequelize } from 'sequelize';
import config from './config'; // 👈 Importás tu config.ts

const env = process.env.NODE_ENV || 'development';
const sequelize = new Sequelize(config[env as keyof typeof config]);

export default sequelize;
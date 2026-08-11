// src/models/User.ts
import { DataTypes, Model, Optional, CreationOptional } from 'sequelize';
import sequelize from '../config/database';

interface UserAttributes {
  id_user: number;
  email: string;
  password: string;
  name: string | null;
  lastname: string | null;
  phone: string | null;
  role: 'admin' | 'mod' | 'user';
  state: 0 | 1 | 2;
  verified: 0 | 1;
  email_verified: 0 | 1;
  verification_token: string | null;
  reset_password_token: string | null;
  reset_password_expires: Date | null;
}

interface UserCreationAttributes extends Optional<UserAttributes, 
  'id_user' | 'name' | 'lastname' | 'phone' | 
  'verification_token' | 'reset_password_token' | 'reset_password_expires'
> {}

class User extends Model<UserAttributes, UserCreationAttributes> {
  declare id_user: CreationOptional<number>;
  declare email: string;
  declare password: string;
  declare name: string | null;
  declare lastname: string | null;
  declare phone: string | null;
  declare role: 'admin' | 'mod' | 'user';
  declare state: 0 | 1 | 2;
  declare verified: 0 | 1;
  declare email_verified: 0 | 1;
  declare verification_token: string | null;
  declare reset_password_token: string | null;
  declare reset_password_expires: Date | null;
  declare readonly created_at: Date;
  declare readonly updated_at: Date;

  // ✅ RELACIONES AGREGADAS ACÁ
  static associate(models: any) {
    User.hasMany(models.Event, {
      foreignKey: 'id_user',
      as: 'events'
    });

    User.hasMany(models.Purchase, {
      foreignKey: 'Users_id_user',
      as: 'purchases'
    });

    User.hasMany(models.Ticket, {
      foreignKey: 'id_user',
      as: 'tickets'
    });

    User.hasMany(models.History, {
      foreignKey: 'id_user',
      as: 'histories'
    });
  }
}

User.init({
  id_user: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false
  },
  email: {
    type: DataTypes.STRING(100),
    allowNull: false,
    unique: true,
    validate: { isEmail: true, notEmpty: true }
  },
  password: {
    type: DataTypes.STRING(255),
    allowNull: false,
    validate: { notEmpty: true, len: [6, 255] }
  },
  name: {
    type: DataTypes.STRING(50),
    allowNull: true
  },
  lastname: {
    type: DataTypes.STRING(50),
    allowNull: true
  },
  phone: {
    type: DataTypes.STRING(20),
    allowNull: true,
    unique: true
  },
  role: {
    type: DataTypes.ENUM('admin', 'mod', 'user'),
    allowNull: false,
    defaultValue: 'user'
  },
  state: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: 1,
    validate: { isIn: [[0, 1, 2]] }
  },
  verified: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: 0,
    validate: { isIn: [[0, 1]] }
  },
  email_verified: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: 0,
    validate: { isIn: [[0, 1]] }
  },
  verification_token: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  reset_password_token: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  reset_password_expires: {
    type: DataTypes.DATE,
    allowNull: true
  }
}, {
  sequelize, 
  modelName: 'User',
  tableName: 'Users',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  underscored: true,
  paranoid: false,
  indexes: [
    { fields: ['email'] },
    { fields: ['state'] },
    { fields: ['role'] },
    { fields: ['email_verified'] },
    { fields: ['name', 'lastname'] }
  ]
});

export default User;
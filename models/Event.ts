// src/models/Event.ts
import { 
  Model, 
  DataTypes, 
  Optional, 
  CreationOptional, 
  Sequelize 
} from 'sequelize';
import sequelize from '../config/database';
import User from './User';
import Purchase from './Purchase';
import Ticket from './Ticket';
import History from './History';

// Atributos del modelo
interface EventAttributes {
  id_event: number;
  name: string;
  description: string | null;
  start_date_time: Date;
  end_date_time: Date;
  province: string | null;
  city: string | null;
  venue: string | null;
  private: boolean;
  authorizated: 0 | 1 | 2;
  state: 'active' | 'cancelled' | 'finished' | 'postponed';
  total_tickets: number;
  available_tickets: number;
  sold_tickets: number;
  id_user: number;
}

// Atributos opcionales al crear
interface EventCreationAttributes extends Optional<EventAttributes, 
  'id_event' | 'description' | 'province' | 'city' | 'venue'
> {}

// Clase del modelo
class Event extends Model<EventAttributes, EventCreationAttributes> {
  // Propiedades
  declare id_event: CreationOptional<number>;
  declare name: string;
  declare description: string | null;
  declare start_date_time: Date;
  declare end_date_time: Date;
  declare province: string | null;
  declare city: string | null;
  declare venue: string | null;
  declare private: boolean;
  declare authorizated: 0 | 1 | 2;
  declare state: 'active' | 'cancelled' | 'finished' | 'postponed';
  declare total_tickets: number;
  declare available_tickets: number;
  declare sold_tickets: number;
  declare id_user: number;
  
  // Timestamps
  declare readonly created_at: Date;
  declare readonly updated_at: Date;

  // Relaciones
  static associate(models: any) {
    Event.belongsTo(User, {
      foreignKey: 'id_user',
      as: 'user'
    });

    Event.hasMany(Purchase, {
      foreignKey: 'Events_id_event',
      as: 'purchases'
    });

    Event.hasMany(Ticket, {
      foreignKey: 'id_event',
      as: 'tickets'
    });

    Event.hasMany(History, {
      foreignKey: 'id_event',
      as: 'histories'
    });
  }
}

// Inicializar el modelo
Event.init({
  id_event: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false
  },
  name: {
    type: DataTypes.STRING(100),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [3, 100]
    }
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  start_date_time: {
    type: DataTypes.DATE,
    allowNull: false,
    validate: {
      isDate: true
    }
  },
  end_date_time: {
    type: DataTypes.DATE,
    allowNull: false,
    validate: {
      isDate: true,
      isAfterStart(value) {
        if (value <= this.start_date_time) {
          throw new Error('La fecha de fin debe ser posterior a la fecha de inicio');
        }
      }
    }
  },
  province: {
    type: DataTypes.STRING(50),
    allowNull: true
  },
  city: {
    type: DataTypes.STRING(50),
    allowNull: true
  },
  venue: {
    type: DataTypes.STRING(100),
    allowNull: true
  },
  private: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false
  },
  authorizated: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: 0,
    validate: {
      isIn: [[0, 1, 2]] // 0=pendiente, 1=autorizado, 2=rechazado
    }
  },
  state: {
    type: DataTypes.ENUM('active', 'cancelled', 'finished', 'postponed'),
    allowNull: false,
    defaultValue: 'active'
  },
  total_tickets: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    validate: {
      min: 0
    }
  },
  available_tickets: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    validate: {
      min: 0
    }
  },
  sold_tickets: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    validate: {
      min: 0
    }
  },
  id_user: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'Users',
      key: 'id_user'
    }
  }
}, {
  sequelize,
  modelName: 'Event',
  tableName: 'Events',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  underscored: true,
  paranoid: false,
  indexes: [
    { fields: ['id_user'] },
    { fields: ['state'] },
    { fields: ['start_date_time'] },
    { fields: ['city'] },
    { fields: ['authorizated'] }
  ]
});

export default Event;
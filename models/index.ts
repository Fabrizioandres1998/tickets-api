// models/index.ts
import User from './User';
import Event from './Event';
import Purchase from './Purchase';
import Ticket from './Ticket';
import History from './History';

// Ejecutar relaciones
User.associate({ Event, Purchase, Ticket, History });
Event.associate({ User, Purchase, Ticket, History });
Purchase.associate({ User, Event });
Ticket.associate({ User, Event });
History.associate({ User, Event });

// Exportar todo
export { User, Event, Purchase, Ticket, History };
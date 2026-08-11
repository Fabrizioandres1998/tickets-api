'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Compra extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Compra.init({
    id_purchase: DataTypes.INTEGER,
    total_tickets: DataTypes.INTEGER,
    total: DataTypes.DECIMAL,
    state: DataTypes.ENUM,
    Eventos_id_event: DataTypes.INTEGER,
    Usuarios_id_user: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Compra',
  });
  return Compra;
};
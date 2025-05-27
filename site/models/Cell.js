const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Warehouse = require('./Warehouse');
const Equipment = require('./Equipment');

const Cell = sequelize.define('Yacheiki', {
idYacheiki: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
SeriinyNomerYacheikji: { type: DataTypes.STRING(45), unique: true, allowNull: false },
Stoimost: DataTypes.STRING(45),
Sklady_idSklady: { type: DataTypes.INTEGER, allowNull: false },
SmejnieOborudovaniya_idSmejnieOborudovaniya: { type: DataTypes.INTEGER, allowNull: false },
}, {
tableName: 'Yacheiki',
});

Cell.belongsTo(Warehouse, { foreignKey: 'Sklady_idSklady' });
Cell.belongsTo(Equipment, { foreignKey: 'SmejnieOborudovaniya_idSmejnieOborudovaniya' });

module.exports = Cell;

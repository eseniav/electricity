const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Warehouse = sequelize.define('Sklady', {
idSklady: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
Raspolojenie: { type: DataTypes.STRING(45), unique: true, allowNull: false },
}, {
tableName: 'Sklady',
});

module.exports = Warehouse;

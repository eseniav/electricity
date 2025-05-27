const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Request = sequelize.define('Zayavki', {
idZayavki: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
NomerZayavki: { type: DataTypes.STRING(45), unique: true, allowNull: true },
DataZayavki: { type: DataTypes.DATEONLY, allowNull: true },
}, {
tableName: 'Zayavki',
});

module.exports = Request;

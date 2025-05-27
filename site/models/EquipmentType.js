const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const EquipmentType = sequelize.define('TipySmejnogoOborudovaniya', {
idTipySmejnogoOborudovaniya: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
NazvanieTipy: { type: DataTypes.STRING(45), unique: true, allowNull: false },
}, {
tableName: 'TipySmejnogoOborudovaniya',
});

module.exports = EquipmentType;

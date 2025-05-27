const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Project = require('./Project');
const EquipmentType = require('./EquipmentType');

const Equipment = sequelize.define('SmejnieOborudovaniya', {
idSmejnieOborudovaniya: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
SeriinyNomerSmejObor: { type: DataTypes.STRING(45), unique: true, allowNull: false },
TemperaturaVozduhaSmejObor: DataTypes.INTEGER,
TemperaturaVodySmejObor: DataTypes.INTEGER,
TokiSmejObor: DataTypes.INTEGER,
NapryajenieSmejObor: DataTypes.INTEGER,
TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya: { type: DataTypes.INTEGER, allowNull: false },
Proekty_idProekty: { type: DataTypes.INTEGER, allowNull: false },
}, {
tableName: 'SmejnieOborudovaniya',
});

Equipment.belongsTo(Project, { foreignKey: 'Proekty_idProekty' });
Equipment.belongsTo(EquipmentType, { foreignKey: 'TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya' });

module.exports = Equipment;

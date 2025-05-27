const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Cell = require('./Cell');
const Request = require('./Request');

const RequestItem = sequelize.define('SostaviZayavok', {
idSostaviZayavok: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
Yacheiki_idYacheiki: { type: DataTypes.INTEGER, allowNull: false },
Zayavki_idZayavki: { type: DataTypes.INTEGER, allowNull: false },
}, {
tableName: 'SostaviZayavok',
});

RequestItem.belongsTo(Cell, { foreignKey: 'Yacheiki_idYacheiki' });
RequestItem.belongsTo(Request, { foreignKey: 'Zayavki_idZayavki' });

module.exports = RequestItem;

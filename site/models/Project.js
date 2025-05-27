const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Project = sequelize.define('Proekty', {
idProekty: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
},
NomerPr: {
    type: DataTypes.STRING(45),
    unique: true,
    allowNull: false,
},
NazvaniePr: {
    type: DataTypes.STRING(45),
    unique: true,
    allowNull: true,
},
}, {
tableName: 'Proekty',
});

module.exports = Project;

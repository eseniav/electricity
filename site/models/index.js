const sequelize = require('../config/database');

const Project = require('./Project');
const Equipment = require('./Equipment');
const EquipmentType = require('./EquipmentType');
const Warehouse = require('./Warehouse');
const Cell = require('./Cell');
const Request = require('./Request');
const RequestItem = require('./RequestItem');

// Связи (если не заданы в моделях)
Project.hasMany(Equipment, { foreignKey: 'Proekty_idProekty' });
Equipment.belongsTo(Project, { foreignKey: 'Proekty_idProekty' });

Equipment.belongsTo(EquipmentType, { foreignKey: 'TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya' });
EquipmentType.hasMany(Equipment, { foreignKey: 'TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya' });

Warehouse.hasMany(Cell, { foreignKey: 'Sklady_idSklady' });
Cell.belongsTo(Warehouse, { foreignKey: 'Sklady_idSklady' });

Equipment.hasMany(Cell, { foreignKey: 'SmejnieOborudovaniya_idSmejnieOborudovaniya' });
Cell.belongsTo(Equipment, { foreignKey: 'SmejnieOborudovaniya_idSmejnieOborudovaniya' });

Request.hasMany(RequestItem, { foreignKey: 'Zayavki_idZayavki' });
RequestItem.belongsTo(Request, { foreignKey: 'Zayavki_idZayavki' });

Cell.hasMany(RequestItem, { foreignKey: 'Yacheiki_idYacheiki' });
RequestItem.belongsTo(Cell, { foreignKey: 'Yacheiki_idYacheiki' });

module.exports = {
sequelize,
Project,
Equipment,
EquipmentType,
Warehouse,
Cell,
Request,
RequestItem,
};

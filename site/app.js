require('dotenv').config();
const express = require('express');
const path = require('path');
const { sequelize, Project, Equipment, EquipmentType, Warehouse, Cell, Request, RequestItem } = require('./models');

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.static(path.join(__dirname, 'public')));

// Главная страница: список проектов
app.get('/', async (req, res) => {
const projects = await Project.findAll();
res.render('index', { projects }); // projects — массив объектов проектов
});

// Детали проекта
app.get('/projects/:id', async (req, res) => {
const projectId = req.params.id;

// Получаем проект
const project = await Project.findByPk(projectId);
if (!project) return res.status(404).send('Проект не найден');

// Получаем оборудование проекта с типом
const equipment = await Equipment.findAll({
    where: { Proekty_idProekty: projectId },
    include: [EquipmentType],
});

// Получаем склады и ячейки с оборудованием для проекта
const warehouses = await Warehouse.findAll({
    include: {
    model: Cell,
    include: {
        model: Equipment,
        where: { Proekty_idProekty: projectId },
        required: false,
    },
    },
});

res.render('project', { project, equipment, warehouses });
});

// Список заявок
app.get('/requests', async (req, res) => {
// Получаем заявки с количеством позиций и общей стоимостью
const requests = await Request.findAll({
    include: {
    model: RequestItem,
    include: {
        model: Cell,
    },
    },
});

// Подсчёт количества позиций и общей стоимости для каждой заявки
const requestsData = requests.map(req => {
    const positionsCount = req.SostaviZayavoks.length;
    const totalCost = req.SostaviZayavoks.reduce((sum, item) => {
    const cost = parseFloat(item.Yacheiki.Stoimost) || 0;
    return sum + cost;
    }, 0);
    return {
    idZayavki: req.idZayavki,
    NomerZayavki: req.NomerZayavki,
    DataZayavki: req.DataZayavki,
    positionsCount,
    totalCost,
    };
});

res.render('requests', { requests: requestsData });
});

// Запуск сервера и проверка подключения к БД
const PORT = process.env.PORT || 3000;
sequelize.authenticate()
.then(() => {
    console.log('Подключение к базе данных успешно');
    app.listen(PORT, () => console.log(`Сервер запущен на порту ${PORT}`));
})
.catch(err => {
    console.error('Ошибка подключения к базе данных:', err);
});

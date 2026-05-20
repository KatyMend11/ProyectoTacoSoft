const express = require('express');
const cors = require('cors');
const path = require('path');

const sucursalesRouter = require('./routes/sucursales');
const categoriasRouter = require('./routes/categorias');
const productosRouter = require('./routes/productos');
const empleadosRouter = require('./routes/empleados');
const clientesRouter = require('./routes/clientes');
const promocionesRouter = require('./routes/promociones');
const pedidosRouter = require('./routes/pedidos');
const reportesRouter = require('./routes/reportes');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '..', 'public')));

app.use('/api/sucursales', sucursalesRouter);
app.use('/api/categorias', categoriasRouter);
app.use('/api/productos', productosRouter);
app.use('/api/empleados', empleadosRouter);
app.use('/api/clientes', clientesRouter);
app.use('/api/promociones', promocionesRouter);
app.use('/api/pedidos', pedidosRouter);
app.use('/api/reportes', reportesRouter);

app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'index.html'));
});

app.listen(PORT, () => {
    console.log(`El Sinaloense POS running on http://localhost:${PORT}`);
});

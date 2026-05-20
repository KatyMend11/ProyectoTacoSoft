const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarProductos', {
            Busqueda: req.query.busqueda || null,
            CategoriaId: req.query.categoriaId ? parseInt(req.query.categoriaId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ObtenerProducto', { Id: parseInt(req.params.id) });
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post('/', async (req, res) => {
    try {
        const { nombre, descripcion, categoriaId, precio, costo } = req.body;
        const result = await executeStoredProcedure('sp_NuevoProducto', {
            Nombre: nombre, Descripcion: descripcion, CategoriaId: parseInt(categoriaId),
            Precio: parseFloat(precio), Costo: parseFloat(costo)
        });
        res.json({ id: result.recordsets[0][0].Id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const { nombre, descripcion, categoriaId, precio, costo } = req.body;
        await executeStoredProcedure('sp_EditarProducto', {
            Id: parseInt(req.params.id), Nombre: nombre, Descripcion: descripcion,
            CategoriaId: parseInt(categoriaId), Precio: parseFloat(precio), Costo: parseFloat(costo)
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        await executeStoredProcedure('sp_BajaProducto', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

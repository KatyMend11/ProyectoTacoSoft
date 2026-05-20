const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

// Listar sucursales
router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarSucursales', {
            Busqueda: req.query.busqueda || null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Obtener sucursal por ID
router.get('/:id', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ObtenerSucursal', { Id: parseInt(req.params.id) });
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Nueva sucursal
router.post('/', async (req, res) => {
    try {
        const { nombre, direccion, ciudad, telefono } = req.body;
        const result = await executeStoredProcedure('sp_NuevaSucursal', {
            Nombre: nombre, Direccion: direccion, Ciudad: ciudad, Telefono: telefono
        });
        res.json({ id: result.recordsets[0][0].Id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Editar sucursal
router.put('/:id', async (req, res) => {
    try {
        const { nombre, direccion, ciudad, telefono } = req.body;
        await executeStoredProcedure('sp_EditarSucursal', {
            Id: parseInt(req.params.id), Nombre: nombre, Direccion: direccion,
            Ciudad: ciudad, Telefono: telefono
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Baja logica
router.delete('/:id', async (req, res) => {
    try {
        await executeStoredProcedure('sp_BajaSucursal', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

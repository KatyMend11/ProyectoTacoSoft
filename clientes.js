const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarClientes', {
            Busqueda: req.query.busqueda || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarClientes', {
            Busqueda: null,
            SucursalId: null
        });
        const cliente = result.recordsets[0].find(c => c.Id === parseInt(req.params.id));
        res.json(cliente || {});
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post('/', async (req, res) => {
    try {
        const { nombre, telefono, correo, sucursalId, ciudad } = req.body;
        const result = await executeStoredProcedure('sp_NuevoCliente', {
            Nombre: nombre, Telefono: telefono, Correo: correo,
            SucursalId: sucursalId ? parseInt(sucursalId) : null, Ciudad: ciudad
        });
        res.json({ id: result.recordsets[0][0].Id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const { nombre, telefono, correo, sucursalId, ciudad } = req.body;
        await executeStoredProcedure('sp_EditarCliente', {
            Id: parseInt(req.params.id), Nombre: nombre, Telefono: telefono,
            Correo: correo, SucursalId: sucursalId ? parseInt(sucursalId) : null, Ciudad: ciudad
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        await executeStoredProcedure('sp_BajaCliente', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

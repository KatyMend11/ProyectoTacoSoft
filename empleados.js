const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarEmpleados', {
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
        const result = await executeStoredProcedure('sp_ObtenerEmpleado', { Id: parseInt(req.params.id) });
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post('/', async (req, res) => {
    try {
        const { nombre, telefono, puesto, sucursalId, salarioQuincenal } = req.body;
        const result = await executeStoredProcedure('sp_NuevoEmpleado', {
            Nombre: nombre, Telefono: telefono, Puesto: puesto,
            SucursalId: parseInt(sucursalId), SalarioQuincenal: parseFloat(salarioQuincenal)
        });
        res.json({ id: result.recordsets[0][0].Id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const { nombre, telefono, puesto, sucursalId, salarioQuincenal } = req.body;
        await executeStoredProcedure('sp_EditarEmpleado', {
            Id: parseInt(req.params.id), Nombre: nombre, Telefono: telefono, Puesto: puesto,
            SucursalId: parseInt(sucursalId), SalarioQuincenal: parseFloat(salarioQuincenal)
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        await executeStoredProcedure('sp_BajaEmpleado', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

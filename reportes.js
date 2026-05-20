const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

router.get('/ventas-sucursal', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteVentasSucursal', {
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/productos-vendidos', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteProductosMasVendidos', {
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null,
            Top: parseInt(req.query.top) || 10
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/ventas-categoria', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteVentasPorCategoria', {
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/rendimiento-empleados', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteRendimientoEmpleados', {
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/comparativo-mensual', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteComparativoMensual', {
            Anio: req.query.anio ? parseInt(req.query.anio) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/productos-sin-movimiento', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ReporteProductosSinMovimiento', {
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

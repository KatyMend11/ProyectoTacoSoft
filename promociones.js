const express = require('express');
const router = express.Router();
const { executeStoredProcedure } = require('../config/db');

router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarPromociones', {
            Busqueda: req.query.busqueda || null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/vigentes', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_PromocionesVigentes', {});
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ObtenerPromocion', { Id: parseInt(req.params.id) });
        const productos = result.recordsets[0].filter(r => r.productoId !== null).map(r => ({
            productoId: r.productoId, nombre: r.productoNombre
        }));
        const promo = {
            id: result.recordsets[0][0].id,
            nombre: result.recordsets[0][0].nombre,
            descripcion: result.recordsets[0][0].descripcion,
            porcentajeDescuento: result.recordsets[0][0].porcentajeDescuento,
            fechaInicio: result.recordsets[0][0].fechaInicio,
            fechaFin: result.recordsets[0][0].fechaFin,
            estatus: result.recordsets[0][0].estatus,
            productos: productos
        };
        res.json(promo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post('/', async (req, res) => {
    try {
        const { nombre, descripcion, porcentajeDescuento, fechaInicio, fechaFin, productos } = req.body;
        const result = await executeStoredProcedure('sp_NuevaPromocion', {
            Nombre: nombre, Descripcion: descripcion,
            PorcentajeDescuento: parseFloat(porcentajeDescuento),
            FechaInicio: fechaInicio, FechaFin: fechaFin,
            ProductosJson: JSON.stringify(productos || [])
        });
        res.json({ id: result.recordsets[0][0].Id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.put('/:id', async (req, res) => {
    try {
        const { nombre, descripcion, porcentajeDescuento, fechaInicio, fechaFin, productos } = req.body;
        await executeStoredProcedure('sp_EditarPromocion', {
            Id: parseInt(req.params.id), Nombre: nombre, Descripcion: descripcion,
            PorcentajeDescuento: parseFloat(porcentajeDescuento),
            FechaInicio: fechaInicio, FechaFin: fechaFin,
            ProductosJson: JSON.stringify(productos || [])
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete('/:id', async (req, res) => {
    try {
        await executeStoredProcedure('sp_BajaPromocion', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.delete('/:id/eliminar', async (req, res) => {
    try {
        await executeStoredProcedure('sp_EliminarPromocion', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.patch('/:id/reactivar', async (req, res) => {
    try {
        await executeStoredProcedure('sp_ReactivarPromocion', { Id: parseInt(req.params.id) });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.get('/:id/productos', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ProductosPromocion', {
            PromocionId: parseInt(req.params.id)
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

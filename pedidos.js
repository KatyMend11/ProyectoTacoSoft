const express = require('express');
const router = express.Router();
const { executeStoredProcedure, sql } = require('../config/db');

// Crear nuevo pedido
router.post('/', async (req, res) => {
    try {
        const { sucursalId, empleadoId, clienteId, promocionId, tipoPedido } = req.body;
        const pool = await require('../config/db').getPool();
        const request = pool.request();
        request.input('SucursalId', sql.Int, parseInt(sucursalId));
        request.input('EmpleadoId', sql.Int, parseInt(empleadoId));
        request.input('ClienteId', clienteId ? sql.Int : sql.Int, clienteId ? parseInt(clienteId) : null);
        request.input('PromocionId', promocionId ? sql.Int : sql.Int, promocionId ? parseInt(promocionId) : null);
        request.input('TipoPedido', sql.NVarChar, tipoPedido);
        request.output('PedidoId', sql.Int);

        const result = await request.execute('sp_NuevoPedido');
        res.json({ id: result.output.PedidoId });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Agregar producto al pedido
router.post('/:id/productos', async (req, res) => {
    try {
        const { productoId, cantidad } = req.body;
        const result = await executeStoredProcedure('sp_AgregarProductoAlPedido', {
            PedidoId: parseInt(req.params.id),
            ProductoId: parseInt(productoId),
            Cantidad: parseInt(cantidad)
        });
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Aplicar promocion al pedido
router.post('/:id/promocion', async (req, res) => {
    try {
        const { promocionId } = req.body;
        const result = await executeStoredProcedure('sp_AplicarPromocion', {
            PedidoId: parseInt(req.params.id),
            PromocionId: parseInt(promocionId)
        });
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Obtener pedido con detalle
router.get('/:id', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ObtenerPedido', {
            PedidoId: parseInt(req.params.id)
        });
        const pedido = result.recordsets[0][0];
        const detalle = result.recordsets[1];
        res.json({ pedido, detalle });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Listar pedidos con filtros
router.get('/', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_ListarPedidos', {
            Estatus: req.query.estatus || null,
            SucursalId: req.query.sucursalId ? parseInt(req.query.sucursalId) : null,
            FechaInicio: req.query.fechaInicio || null,
            FechaFin: req.query.fechaFin || null
        });
        res.json(result.recordsets[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Cambiar estatus del pedido
router.patch('/:id/estatus', async (req, res) => {
    try {
        const { nuevoEstatus } = req.body;
        await executeStoredProcedure('sp_CambiarEstatusPedido', {
            PedidoId: parseInt(req.params.id),
            NuevoEstatus: nuevoEstatus
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Cancelar pedido
router.patch('/:id/cancelar', async (req, res) => {
    try {
        await executeStoredProcedure('sp_CancelarPedido', {
            PedidoId: parseInt(req.params.id)
        });
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Cancelar pedidos pendientes vencidos (+24h)
router.post('/cancelar-vencidos', async (req, res) => {
    try {
        const result = await executeStoredProcedure('sp_CancelarPedidosPendientesVencidos', {});
        res.json(result.recordsets[0][0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

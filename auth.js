const express = require('express');
const router = express.Router();
const { executeStoredProcedure, sql, getPool } = require('../config/db');

router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        const pool = await getPool();
        const result = await pool.request()
            .input('Username', sql.NVarChar, username)
            .input('Password', sql.NVarChar, password)
            .execute('sp_Login');

        const user = result.recordsets[0][0];
        if (!user) {
            return res.status(401).json({ error: 'Usuario o contrasena incorrectos' });
        }
        if (user.estatus === 0) {
            return res.status(401).json({ error: 'Cuenta desactivada' });
        }

        res.json({
            id: user.id,
            username: user.username,
            rol: user.rol,
            empleadoId: user.empleadoId,
            empleadoNombre: user.empleadoNombre,
            sucursalId: user.sucursalId,
            sucursalNombre: user.sucursalNombre
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

router.post('/logout', async (req, res) => {
    res.json({ success: true });
});

router.get('/me', async (req, res) => {
    res.json({ authenticated: false });
});

module.exports = router;

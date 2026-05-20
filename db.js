require('dotenv').config();
const sql = require('mssql');

const config = {
    user: process.env.DB_USER || 'ElSinaloense',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'ElSinaloensePOS',
    server: process.env.DB_SERVER || 'DESKTOP-SUIFTH5',
    driver: 'msnodesqlv8',
    options: {
        encrypt: false,
        trustServerCertificate: true,
        enableArithAbort: true
    },
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    }
};

let pool;

async function getPool() {
    if (!pool) {
        pool = await sql.connect(config);
    }
    return pool;
}

async function executeStoredProcedure(spName, params) {
    try {
        const pool = await getPool();
        const request = pool.request();

        if (params) {
            for (const [key, value] of Object.entries(params)) {
                request.input(key, value);
            }
        }

        const result = await request.execute(spName);
        return result;
    } catch (error) {
        console.error(`Error executing ${spName}:`, error.message);
        throw error;
    }
}

module.exports = { getPool, executeStoredProcedure, sql };

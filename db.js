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

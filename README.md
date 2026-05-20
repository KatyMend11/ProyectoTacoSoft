# El Sinaloense POS - Sistema de Punto de Venta

Sistema de punto de venta web para la cadena de taquerias "El Sinaloense" con 4 sucursales en Sinaloa.

## Stack Tecnológico

- **Frontend**: HTML / CSS / JavaScript vanilla
- **Backend**: Node.js con Express
- **Base de datos**: SQL Server
- **Conexion**: Paquete mssql de npm

## Estructura del Proyecto

```
el-sinaloense-pos/
├── sql/
│   ├── 01_schema.sql              # Esquema de la base de datos
│   ├── 02_stored_procedures.sql   # Procedimientos almacenados
│   └── 03_seed_data.sql           # Datos de prueba
├── src/
│   ├── config/
│   │   └── db.js                  # Configuracion de conexion a BD
│   ├── routes/
│   │   ├── sucursales.js
│   │   ├── categorias.js
│   │   ├── productos.js
│   │   ├── empleados.js
│   │   ├── clientes.js
│   │   ├── promociones.js
│   │   ├── pedidos.js
│   │   └── reportes.js
│   └── server.js                  # Servidor Express
├── public/
│   ├── css/
│   │   └── styles.css
│   ├── js/
│   │   ├── api.js                 # Funciones de API
│   │   └── app.js                 # Logica de la aplicacion
│   └── index.html                 # Pagina principal
└── package.json
```

## Instalacion y Configuracion

### 1. Requisitos

- Node.js 18+
- SQL Server 2019+

### 2. Configurar la Base de Datos

Ejecutar los scripts SQL en orden en SQL Server Management Studio:

```sql
-- 1. Crear esquema
sqlcmd -S localhost -U sa -P YourPassword123 -i sql/01_schema.sql

-- 2. Crear procedimientos almacenados
sqlcmd -S localhost -U sa -P YourPassword123 -i sql/02_stored_procedures.sql

-- 3. Insertar datos de prueba
sqlcmd -S localhost -U sa -P YourPassword123 -i sql/03_seed_data.sql
```

O abre cada archivo en SSMS y ejecutalo.

### 3. Configurar la Conexion

Crea el archivo `.env` en la raiz del proyecto con tus credenciales:

```env
DB_SERVER=DESKTOP-SUIFTH5
DB_NAME=ElSinaloensePOS
DB_USER=ElSinaloense
DB_PASSWORD=tu_contrasena
PORT=3000
```

**Importante:** El archivo `.env` NUNCA debe subirse al repositorio. Contiene credenciales sensibles.


### 4. Instalar Dependencias

```bash
npm install
```

### 5. Ejecutar la Aplicacion

```bash
# Desarrollo
npm run dev

# Produccion
npm start
```

La aplicacion estara disponible en: http://localhost:3000

## Modulos del Sistema

### Modulo 1 - Punto de Venta

Pantalla donde el cajero toma pedidos:
1. Selecciona sucursal e ingresa ID de empleado
2. Opcionalmente busca o registra cliente
3. Selecciona tipo de pedido (local, llevar, domicilio)
4. Agrega productos navegando por categorias
5. Aplica promociones vigentes
6. Confirma el pedido

### Modulo 2 - Gestion de Pedidos

- Ver pedidos filtrados por estatus
- Cambiar estatus siguiendo flujo lineal: pendiente -> preparando -> listo -> entregado
- Cancelar pedidos (solo pendiente o preparando)
- Ver detalle completo de cualquier pedido
- Cancelar automaticamente pedidos pendientes con +24 horas

### Modulo 3 - Catalogos (CRUD)

Administra la informacion base del sistema:
- **Sucursales**: Nombre, direccion, ciudad, telefono, estatus
- **Categorias**: Nombre, descripcion
- **Productos**: Nombre, descripcion, categoria, precio, costo, estatus
- **Empleados**: Nombre, telefono, puesto (cajero, cocinero, repartidor, gerente, mesero), sucursal, salario, fecha ingreso, estatus
- **Clientes**: Nombre, telefono, correo, ciudad, fecha registro
- **Promociones**: Nombre, descripcion, descuento, fechas, productos

### Modulo 4 - Dashboard de Reportes

- Ventas por sucursal (total pedidos, total pesos, ticket promedio)
- Productos mas vendidos (Top 10)
- Ventas por categoria
- Rendimiento de empleados (solo > 5 pedidos)
- Comparativo mensual
- Productos sin movimiento

## Reglas de Negocio

1. Cada sucursal debe tener exactamente UN gerente
2. Un pedido cancelado NUNCA se puede reactivar
3. El precio unitario en el detalle se COPIA al momento de la venta
4. Las promociones solo aplican a productos especificos (tabla puente)
5. Un empleado inactivo NO puede atender pedidos nuevos
6. NUNCA se eliminan registros fisicamente (baja logica)
7. Los procedimientos almacenados usan TRY/CATCH y TRANSACTIONS
8. El backend usa queries parametrizados (previene SQL Injection)

## Datos de Prueba

El sistema incluye datos minimos de prueba:
- 4 sucursales (Culiacan, Mazatlan, Los Mochis, Guasave)
- 5 categorias (Tacos, Burritos, Bebidas, Postres, Extras)
- 20 productos
- 18 empleados (al menos 3 por sucursal, 1 gerente y 1 mesero por sucursal)
- 10 clientes frecuentes
- 36 pedidos (30 historicos + 6 activos)
- 60+ lineas de detalle
- 3 promociones (1 vigente, 1 expirada, 1 con productos)

## API Endpoints

| Metodo | Endpoint | Descripcion |
|--------|----------|-------------|
| GET | /api/sucursales | Listar sucursales |
| POST | /api/sucursales | Nueva sucursal |
| PUT | /api/sucursales/:id | Editar sucursal |
| DELETE | /api/sucursales/:id | Baja logica |
| GET | /api/categorias | Listar categorias |
| POST | /api/categorias | Nueva categoria |
| PUT | /api/categorias/:id | Editar categoria |
| DELETE | /api/categorias/:id | Eliminar categoria |
| GET | /api/productos | Listar productos |
| POST | /api/productos | Nuevo producto |
| PUT | /api/productos/:id | Editar producto |
| DELETE | /api/productos/:id | Baja producto |
| GET | /api/empleados | Listar empleados |
| POST | /api/empleados | Nuevo empleado |
| PUT | /api/empleados/:id | Editar empleado |
| DELETE | /api/empleados/:id | Baja empleado |
| GET | /api/clientes | Listar clientes |
| POST | /api/clientes | Nuevo cliente |
| PUT | /api/clientes/:id | Editar cliente |
| DELETE | /api/clientes/:id | Baja cliente |
| GET | /api/promociones | Listar promociones |
| POST | /api/promociones | Nueva promocion |
| PUT | /api/promociones/:id | Editar promocion |
| DELETE | /api/promociones/:id | Baja promocion |
| GET | /api/promociones/vigentes | Promociones vigentes |
| POST | /api/pedidos | Nuevo pedido |
| POST | /api/pedidos/:id/productos | Agregar producto al pedido |
| POST | /api/pedidos/:id/promocion | Aplicar promocion |
| GET | /api/pedidos/:id | Obtener pedido con detalle |
| GET | /api/pedidos | Listar pedidos con filtros |
| PATCH | /api/pedidos/:id/estatus | Cambiar estatus |
| PATCH | /api/pedidos/:id/cancelar | Cancelar pedido |
| POST | /api/pedidos/cancelar-vencidos | Cancelar pendientes +24h |
| GET | /api/reportes/ventas-sucursal | Ventas por sucursal |
| GET | /api/reportes/productos-vendidos | Top productos vendidos |
| GET | /api/reportes/ventas-categoria | Ventas por categoria |
| GET | /api/reportes/rendimiento-empleados | Rendimiento empleados |
| GET | /api/reportes/comparativo-mensual | Comparativo mensual |
| GET | /api/reportes/productos-sin-movimiento | Productos sin ventas |

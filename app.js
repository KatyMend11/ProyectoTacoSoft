
let cart = [];
let allSucursales = [];
let allCategorias = [];
let allEmpleados = [];
let allClientes = [];
let allPromociones = [];

// ==================== UTILS ====================
function formatMoney(n) {
    return '$' + Number(n).toLocaleString('es-MX', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function formatDate(d) {
    if (!d) return '-';
    const date = new Date(d);
    return date.toLocaleDateString('es-MX') + ' ' + date.toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
}

function formatDateShort(d) {
    if (!d) return '-';
    return new Date(d).toLocaleDateString('es-MX');
}

function showToast(msg, type = 'success') {
    const container = document.getElementById('toastContainer');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = msg;
    container.appendChild(toast);
    setTimeout(() => toast.remove(), 3000);
}

// ==================== NAVIGATION ====================
document.querySelectorAll('.nav-btn[data-section]').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.nav-btn[data-section]').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.getElementById(btn.dataset.section).classList.add('active');
        if (btn.dataset.section === 'pedidos') cargarPedidos();
        if (btn.dataset.section === 'dashboard') cargarDashboard();
    });
});

document.querySelectorAll('.nav-btn[data-catalog]').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.nav-btn[data-catalog]').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('.catalog-panel').forEach(p => p.style.display = 'none');
        document.getElementById(`cat-${btn.dataset.catalog}`).style.display = 'block';
    });
});

document.querySelectorAll('#orderFilters .status-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('#orderFilters .status-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        cargarPedidos();
    });
});

// ==================== POPULATE SELECTS ====================
function populateSucursalSelects() {
    const selects = ['posSucursal', 'pedidosSucursal', 'dashSucursal', 'filterSucursalEmpleado'];
    selects.forEach(id => {
        const sel = document.getElementById(id);
        if (!sel) return;
        const firstOpt = sel.options[0] ? sel.options[0].outerHTML : '<option value="">-- Seleccionar --</option>';
        sel.innerHTML = firstOpt;
        allSucursales.filter(s => s.estatus).forEach(s => {
            sel.innerHTML += `<option value="${s.Id}">${s.nombre}</option>`;
        });
    });
}

function populateCategoriaFilter() {
    const sel = document.getElementById('filterCategoria');
    if (!sel) return;
    sel.innerHTML = '<option value="">Todas las categorias</option>';
    allCategorias.forEach(c => {
        sel.innerHTML += `<option value="${c.Id}">${c.nombre}</option>`;
    });
}

function populateEmpleadoSelect() {
    const sucursalId = document.getElementById('posSucursal').value;
    const sel = document.getElementById('posEmpleado');
    sel.innerHTML = '<option value="">Seleccionar empleado</option>';
    if (!sucursalId) return;
    allEmpleados.filter(e => e.estatus && e.sucursalId == sucursalId).forEach(e => {
        sel.innerHTML += `<option value="${e.Id}">${e.nombre} - ${e.puesto}</option>`;
    });
}

function populateClienteSelect() {
    const sucursalId = document.getElementById('posSucursal').value;
    const sel = document.getElementById('posCliente');
    sel.innerHTML = '<option value="">Publico General</option>';
    if (!sucursalId) return;
    allClientes.filter(c => c.estatus && c.sucursalId == parseInt(sucursalId)).forEach(c => {
        sel.innerHTML += `<option value="${c.Id}">${c.nombre} - ${c.ciudad}</option>`;
    });
}

function setDefaultDates() {
    const today = new Date();
    const monthAgo = new Date(today);
    monthAgo.setMonth(monthAgo.getMonth() - 1);
    document.getElementById('dashFechaInicio').value = monthAgo.toISOString().split('T')[0];
    document.getElementById('dashFechaFin').value = today.toISOString().split('T')[0];
}

// ==================== SUCURSALES ====================
async function loadSucursales() {
    const busqueda = document.getElementById('searchSucursal')?.value || '';
    const data = await apiGet(`/sucursales?busqueda=${busqueda}`);
    allSucursales = data;
    const tbody = document.getElementById('sucursalesTable');
    tbody.innerHTML = data.map(s => `
        <tr>
            <td>${s.nombre}</td>
            <td>${s.direccion}</td>
            <td>${s.ciudad}</td>
            <td>${s.telefono}</td>
            <td><span class="badge ${s.estatus ? 'badge-success' : 'badge-danger'}">${s.estatus ? 'Activa' : 'Cerrada'}</span></td>
            <td>
                <button class="btn btn-info btn-sm" onclick="editSucursal(${s.Id})">Editar</button>
                <button class="btn btn-danger btn-sm" onclick="bajaSucursal(${s.Id})">Baja</button>
            </td>
        </tr>
    `).join('');
    populateSucursalSelects();
}

function openModal(type, data = null) {
    const overlay = document.getElementById('modalOverlay');
    const title = document.getElementById('modalTitle');
    const body = document.getElementById('modalBody');
    const saveBtn = document.getElementById('modalSave');

    let html = '';
    switch(type) {
        case 'sucursal':
            title.textContent = data ? 'Editar Sucursal' : 'Nueva Sucursal';
            html = `
                <div class="form-row">
                    <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                    <div class="form-group"><label>Ciudad</label><input id="mCiudad" class="form-control" value="${data?.ciudad || ''}"></div>
                </div>
                <div class="form-group"><label>Direccion</label><input id="mDireccion" class="form-control" value="${data?.direccion || ''}"></div>
                <div class="form-group"><label>Telefono</label><input id="mTelefono" class="form-control" value="${data?.telefono || ''}"></div>
            `;
            saveBtn.onclick = () => saveSucursal(data?.Id);
            break;
        case 'categoria':
            title.textContent = data ? 'Editar Categoria' : 'Nueva Categoria';
            html = `
                <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                <div class="form-group"><label>Descripcion</label><input id="mDescripcion" class="form-control" value="${data?.descripcion || ''}"></div>
            `;
            saveBtn.onclick = () => saveCategoria(data?.Id);
            break;
        case 'producto':
            title.textContent = data ? 'Editar Producto' : 'Nuevo Producto';
            html = `
                <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                <div class="form-group"><label>Descripcion</label><input id="mDescripcion" class="form-control" value="${data?.descripcion || ''}"></div>
                <div class="form-row">
                    <div class="form-group"><label>Categoria</label><select id="mCategoriaId" class="form-control">${allCategorias.map(c => `<option value="${c.Id}" ${data?.categoriaId === c.Id ? 'selected' : ''}>${c.nombre}</option>`).join('')}</select></div>
                    <div class="form-group"><label>Precio</label><input id="mPrecio" type="number" step="0.01" class="form-control" value="${data?.precio || ''}"></div>
                    <div class="form-group"><label>Costo</label><input id="mCosto" type="number" step="0.01" class="form-control" value="${data?.costo || ''}"></div>
                </div>
            `;
            saveBtn.onclick = () => saveProducto(data?.Id);
            break;
        case 'empleado':
            title.textContent = data ? 'Editar Empleado' : 'Nuevo Empleado';
            html = `
                <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                <div class="form-row">
                    <div class="form-group"><label>Telefono</label><input id="mTelefono" class="form-control" value="${data?.telefono || ''}"></div>
                    <div class="form-group"><label>Puesto</label>
                        <select id="mPuesto" class="form-control">
                            <option value="cajero" ${data?.puesto === 'cajero' ? 'selected' : ''}>Cajero</option>
                            <option value="cocinero" ${data?.puesto === 'cocinero' ? 'selected' : ''}>Cocinero</option>
                            <option value="repartidor" ${data?.puesto === 'repartidor' ? 'selected' : ''}>Repartidor</option>
                            <option value="gerente" ${data?.puesto === 'gerente' ? 'selected' : ''}>Gerente</option>
                            <option value="mesero" ${data?.puesto === 'mesero' ? 'selected' : ''}>Mesero</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group"><label>Sucursal</label><select id="mSucursalId" class="form-control">${allSucursales.filter(s => s.estatus).map(s => `<option value="${s.Id}" ${data?.sucursalId === s.Id ? 'selected' : ''}>${s.nombre}</option>`).join('')}</select></div>
                    <div class="form-group"><label>Salario Quincenal</label><input id="mSalario" type="number" step="0.01" class="form-control" value="${data?.salarioQuincenal || ''}"></div>
                </div>
            `;
            saveBtn.onclick = () => saveEmpleado(data?.Id);
            break;
        case 'cliente':
            title.textContent = data ? 'Editar Cliente' : 'Nuevo Cliente';
            html = `
                <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                <div class="form-row">
                    <div class="form-group"><label>Telefono</label><input id="mTelefono" class="form-control" value="${data?.telefono || ''}"></div>
                    <div class="form-group"><label>Correo</label><input id="mCorreo" class="form-control" value="${data?.correo || ''}"></div>
                </div>
                <div class="form-row">
                    <div class="form-group"><label>Sucursal</label><select id="mSucursalId" class="form-control"><option value="">Sin sucursal</option>${allSucursales.filter(s => s.estatus).map(s => `<option value="${s.Id}" ${data?.sucursalId === s.Id ? 'selected' : ''}>${s.nombre}</option>`).join('')}</select></div>
                    <div class="form-group"><label>Ciudad</label><input id="mCiudad" class="form-control" value="${data?.ciudad || ''}"></div>
                </div>
            `;
            saveBtn.onclick = () => saveCliente(data?.Id);
            break;
        case 'promocion':
            title.textContent = data ? 'Editar Promocion' : 'Nueva Promocion';
            const productosHtml = allProductos.filter(p => p.estatus).map(p => {
                const checked = data?.productos?.some(x => x.productoId === p.Id) ? 'checked' : '';
                return `<label style="display:block;padding:0.3rem"><input type="checkbox" value="${p.Id}" ${checked}> ${p.nombre}</label>`;
            }).join('');
            html = `
                <div class="form-group"><label>Nombre</label><input id="mNombre" class="form-control" value="${data?.nombre || ''}"></div>
                <div class="form-group"><label>Descripcion</label><input id="mDescripcion" class="form-control" value="${data?.descripcion || ''}"></div>
                <div class="form-row">
                    <div class="form-group"><label>Descuento %</label><input id="mPorcentaje" type="number" step="0.01" class="form-control" value="${data?.porcentajeDescuento || ''}"></div>
                    <div class="form-group"><label>Fecha Inicio</label><input id="mFechaInicio" type="date" class="form-control" value="${data?.fechaInicio ? new Date(data.fechaInicio).toISOString().split('T')[0] : ''}"></div>
                    <div class="form-group"><label>Fecha Fin</label><input id="mFechaFin" type="date" class="form-control" value="${data?.fechaFin ? new Date(data.fechaFin).toISOString().split('T')[0] : ''}"></div>
                </div>
                <div class="form-group"><label>Productos que aplican</label>
                    <div id="mProductos" style="max-height:200px;overflow-y:auto;border:1px solid var(--gray-light);border-radius:var(--radius);padding:0.5rem">${productosHtml}</div>
                </div>
            `;
            saveBtn.onclick = () => savePromocion(data?.Id);
            break;
    }

    body.innerHTML = html;
    overlay.classList.add('active');
}

function closeModal() {
    document.getElementById('modalOverlay').classList.remove('active');
}

async function saveSucursal(id) {
    try {
        const data = {
            nombre: document.getElementById('mNombre').value,
            direccion: document.getElementById('mDireccion').value,
            ciudad: document.getElementById('mCiudad').value,
            telefono: document.getElementById('mTelefono').value
        };
        if (id) await apiPut(`/sucursales/${id}`, data);
        else await apiPost('/sucursales', data);
        closeModal();
        await loadSucursales();
        showToast(id ? 'Sucursal actualizada' : 'Sucursal creada');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editSucursal(id) {
    const data = await apiGet(`/sucursales/${id}`);
    openModal('sucursal', data);
}

async function bajaSucursal(id) {
    if (!confirm('Dar de baja esta sucursal?')) return;
    await apiDelete(`/sucursales/${id}`);
    await loadSucursales();
    showToast('Sucursal dada de baja');
}

// ==================== CATEGORIAS ====================
async function loadCategorias() {
    const busqueda = document.getElementById('searchCategoria')?.value || '';
    const data = await apiGet(`/categorias?busqueda=${busqueda}`);
    allCategorias = data;
    document.getElementById('categoriasTable').innerHTML = data.map(c => `
        <tr>
            <td>${c.nombre}</td>
            <td>${c.descripcion || '-'}</td>
            <td>
                <button class="btn btn-info btn-sm" onclick="editCategoria(${c.Id})">Editar</button>
                <button class="btn btn-danger btn-sm" onclick="bajaCategoria(${c.Id})">Eliminar</button>
            </td>
        </tr>
    `).join('');
    populateCategoriaFilter();
    loadPosCategories();
}

async function saveCategoria(id) {
    try {
        const data = {
            nombre: document.getElementById('mNombre').value,
            descripcion: document.getElementById('mDescripcion').value
        };
        if (id) await apiPut(`/categorias/${id}`, data);
        else await apiPost('/categorias', data);
        closeModal();
        await loadCategorias();
        showToast(id ? 'Categoria actualizada' : 'Categoria creada');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editCategoria(id) {
    const data = await apiGet(`/categorias/${id}`);
    openModal('categoria', data);
}

async function bajaCategoria(id) {
    if (!confirm('Eliminar esta categoria y desactivar sus productos?')) return;
    await apiDelete(`/categorias/${id}`);
    await loadCategorias();
    showToast('Categoria eliminada');
}

// ==================== PRODUCTOS ====================
let allProductos = [];

async function loadProductos() {
    const busqueda = document.getElementById('searchProducto')?.value || '';
    const categoriaId = document.getElementById('filterCategoria')?.value || '';
    const data = await apiGet('/productos');
    allProductos = data;
    const filtered = allProductos.filter(p => {
        const matchBusqueda = !busqueda || p.nombre.toLowerCase().includes(busqueda.toLowerCase());
        const matchCategoria = !categoriaId || p.categoriaId == categoriaId;
        return matchBusqueda && matchCategoria;
    });
    document.getElementById('productosTable').innerHTML = filtered.map(p => `
        <tr>
            <td>${p.nombre}</td>
            <td>${p.categoria}</td>
            <td>${formatMoney(p.precio)}</td>
            <td>${formatMoney(p.costo)}</td>
            <td><span class="badge ${p.estatus ? 'badge-success' : 'badge-danger'}">${p.estatus ? 'Disponible' : 'No disponible'}</span></td>
            <td>
                <button class="btn btn-info btn-sm" onclick="editProducto(${p.Id})">Editar</button>
                <button class="btn btn-danger btn-sm" onclick="bajaProducto(${p.Id})">Baja</button>
            </td>
        </tr>
    `).join('');
}

async function saveProducto(id) {
    try {
        const data = {
            nombre: document.getElementById('mNombre').value,
            descripcion: document.getElementById('mDescripcion').value,
            categoriaId: parseInt(document.getElementById('mCategoriaId').value),
            precio: parseFloat(document.getElementById('mPrecio').value),
            costo: parseFloat(document.getElementById('mCosto').value)
        };
        if (id) await apiPut(`/productos/${id}`, data);
        else await apiPost('/productos', data);
        closeModal();
        await loadProductos();
        loadPosProducts();
        showToast(id ? 'Producto actualizado' : 'Producto creado');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editProducto(id) {
    const data = await apiGet(`/productos/${id}`);
    openModal('producto', data);
}

async function bajaProducto(id) {
    if (!confirm('Dar de baja este producto?')) return;
    await apiDelete(`/productos/${id}`);
    await loadProductos();
    loadPosProducts();
    showToast('Producto dado de baja');
}

// ==================== EMPLEADOS ====================
async function loadEmpleados() {
    const busqueda = document.getElementById('searchEmpleado')?.value || '';
    const sucursalId = document.getElementById('filterSucursalEmpleado')?.value || '';
    const data = await apiGet(`/empleados?busqueda=${busqueda}&sucursalId=${sucursalId}`);
    allEmpleados = data;
    document.getElementById('empleadosTable').innerHTML = data.map(e => `
        <tr>
            <td>${e.nombre}</td>
            <td>${e.telefono || '-'}</td>
            <td><span class="badge badge-info">${e.puesto}</span></td>
            <td>${e.sucursal}</td>
            <td>${formatMoney(e.salarioQuincenal)}</td>
            <td>${formatDateShort(e.fechaIngreso)}</td>
            <td><span class="badge ${e.estatus ? 'badge-success' : 'badge-danger'}">${e.estatus ? 'Activo' : 'Inactivo'}</span></td>
            <td>
                <button class="btn btn-info btn-sm" onclick="editEmpleado(${e.Id})">Editar</button>
                <button class="btn btn-danger btn-sm" onclick="bajaEmpleado(${e.Id})">Baja</button>
            </td>
        </tr>
    `).join('');
    populateEmpleadoSelect();
}

async function saveEmpleado(id) {
    try {
        const data = {
            nombre: document.getElementById('mNombre').value,
            telefono: document.getElementById('mTelefono').value,
            puesto: document.getElementById('mPuesto').value,
            sucursalId: parseInt(document.getElementById('mSucursalId').value),
            salarioQuincenal: parseFloat(document.getElementById('mSalario').value)
        };
        if (id) await apiPut(`/empleados/${id}`, data);
        else await apiPost('/empleados', data);
        closeModal();
        await loadEmpleados();
        showToast(id ? 'Empleado actualizado' : 'Empleado creado');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editEmpleado(id) {
    const data = await apiGet(`/empleados/${id}`);
    openModal('empleado', data);
}

async function bajaEmpleado(id) {
    if (!confirm('Dar de baja este empleado?')) return;
    await apiDelete(`/empleados/${id}`);
    await loadEmpleados();
    showToast('Empleado dado de baja');
}

// ==================== CLIENTES ====================
async function loadClientes() {
    const busqueda = document.getElementById('searchCliente')?.value || '';
    const data = await apiGet(`/clientes?busqueda=${busqueda}`);
    allClientes = data;
    document.getElementById('clientesTable').innerHTML = data.map(c => `
        <tr>
            <td>${c.nombre}</td>
            <td>${c.telefono || '-'}</td>
            <td>${c.correo || '-'}</td>
            <td>${c.sucursal || '-'}</td>
            <td>${c.ciudad || '-'}</td>
            <td>${formatDateShort(c.fechaRegistro)}</td>
            <td>
                <button class="btn btn-info btn-sm" onclick="editCliente(${c.Id})">Editar</button>
                <button class="btn btn-danger btn-sm" onclick="bajaCliente(${c.Id})">Baja</button>
            </td>
        </tr>
    `).join('');
    populateClienteSelect();
}

async function saveCliente(id) {
    try {
        const data = {
            nombre: document.getElementById('mNombre').value,
            telefono: document.getElementById('mTelefono').value,
            correo: document.getElementById('mCorreo').value,
            sucursalId: document.getElementById('mSucursalId').value || null,
            ciudad: document.getElementById('mCiudad').value
        };
        if (id) await apiPut(`/clientes/${id}`, data);
        else await apiPost('/clientes', data);
        closeModal();
        await loadClientes();
        populateClienteSelect();
        showToast(id ? 'Cliente actualizado' : 'Cliente creado');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editCliente(id) {
    const data = await apiGet(`/clientes/${id}`);
    openModal('cliente', data);
}

async function bajaCliente(id) {
    if (!confirm('Dar de baja este cliente?')) return;
    await apiDelete(`/clientes/${id}`);
    await loadClientes();
    showToast('Cliente dado de baja');
}

// ==================== PROMOCIONES ====================
async function loadPromociones() {
    const busqueda = document.getElementById('searchPromocion')?.value || '';
    const data = await apiGet(`/promociones?busqueda=${busqueda}`);
    document.getElementById('promocionesTable').innerHTML = data.map(p => {
        const acciones = p.estatus
            ? `<button class="btn btn-info btn-sm" onclick="editPromocion(${p.Id})">Editar</button>
               <button class="btn btn-warning btn-sm" onclick="bajaPromocion(${p.Id})">Baja</button>
               <button class="btn btn-danger btn-sm" onclick="eliminarPromocion(${p.Id})">Eliminar</button>`
            : `<button class="btn btn-info btn-sm" onclick="editPromocion(${p.Id})">Editar</button>
               <button class="btn btn-success btn-sm" onclick="reactivarPromocion(${p.Id})">Reactivar</button>
               <button class="btn btn-danger btn-sm" onclick="eliminarPromocion(${p.Id})">Eliminar</button>`;
        return `
        <tr>
            <td>${p.nombre}</td>
            <td>${p.porcentajeDescuento}%</td>
            <td>${formatDateShort(p.fechaInicio)}</td>
            <td>${formatDateShort(p.fechaFin)}</td>
            <td><span class="badge ${p.vigente ? 'badge-success' : 'badge-secondary'}">${p.vigente ? 'Vigente' : 'No vigente'}</span></td>
            <td><span class="badge ${p.estatus ? 'badge-success' : 'badge-danger'}">${p.estatus ? 'Activa' : 'Inactiva'}</span></td>
            <td>${acciones}</td>
        </tr>`;
    }).join('');
    loadPosPromociones();
}

async function savePromocion(id) {
    try {
        const productos = Array.from(document.querySelectorAll('#mProductos input:checked')).map(cb => parseInt(cb.value));
        const data = {
            nombre: document.getElementById('mNombre').value,
            descripcion: document.getElementById('mDescripcion').value,
            porcentajeDescuento: parseFloat(document.getElementById('mPorcentaje').value),
            fechaInicio: document.getElementById('mFechaInicio').value,
            fechaFin: document.getElementById('mFechaFin').value,
            productos: productos
        };
        if (id) await apiPut(`/promociones/${id}`, data);
        else await apiPost('/promociones', data);
        closeModal();
        await loadPromociones();
        showToast(id ? 'Promocion actualizada' : 'Promocion creada');
    } catch (e) { showToast(e.message, 'error'); }
}

async function editPromocion(id) {
    const data = await apiGet(`/promociones/${id}`);
    openModal('promocion', data);
}

async function bajaPromocion(id) {
    if (!confirm('Dar de baja esta promocion?')) return;
    await apiDelete(`/promociones/${id}`);
    await loadPromociones();
    showToast('Promocion dada de baja');
}

async function eliminarPromocion(id) {
    if (!confirm('Eliminar permanentemente esta promocion? Esta accion no se puede deshacer.')) return;
    try {
        await apiDelete(`/promociones/${id}/eliminar`);
        await loadPromociones();
        showToast('Promocion eliminada permanentemente');
    } catch (e) {
        showToast(e.message, 'error');
    }
}

async function reactivarPromocion(id) {
    if (!confirm('Reactivar esta promocion?')) return;
    try {
        await apiPatch(`/promociones/${id}/reactivar`, {});
        await loadPromociones();
        showToast('Promocion reactivada');
    } catch (e) {
        showToast(e.message, 'error');
    }
}

// ==================== PUNTO DE VENTA ====================
document.getElementById('posSucursal').addEventListener('change', () => {
    populateEmpleadoSelect();
    populateClienteSelect();
});

function loadPosCategories() {
    const container = document.getElementById('posCategories');
    if (!container) return;
    container.innerHTML = `<button class="cat-btn active" data-cat="">Todos</button>` +
        allCategorias.map(c => `<button class="cat-btn" data-cat="${c.Id}">${c.nombre}</button>`).join('');
}

document.getElementById('posCategories').addEventListener('click', (e) => {
    const btn = e.target.closest('.cat-btn');
    if (!btn) return;
    const container = document.getElementById('posCategories');
    container.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    loadPosProducts(btn.dataset.cat);
});

function loadPosProducts(categoriaId = '') {
    const container = document.getElementById('posProducts');
    if (!container) return;
    const cid = categoriaId ? parseInt(categoriaId) : null;
    const products = cid ? allProductos.filter(p => p.categoriaId === cid) : allProductos;
    container.innerHTML = products.map(p => `
        <div class="product-card ${p.estatus ? '' : 'disabled'}" data-id="${p.Id}" data-precio="${p.precio}">
            <h4>${p.nombre}</h4>
            <p style="font-size:0.8rem;color:var(--gray)">${p.descripcion || ''}</p>
            <div class="price">${formatMoney(p.precio)}</div>
            ${!p.estatus ? '<div class="badge badge-danger">No disponible</div>' : ''}
        </div>
    `).join('');
}

document.getElementById('posProducts').addEventListener('click', (e) => {
    const card = e.target.closest('.product-card');
    if (!card || card.classList.contains('disabled')) return;
    const productoId = parseInt(card.dataset.id);
    const precio = parseFloat(card.dataset.precio);
    addToCart(productoId, precio, card);
});

function addToCart(productoId, precio, element) {
    productoId = parseInt(productoId);
    precio = parseFloat(precio);
    const nombre = element.querySelector('h4').textContent;
    const existing = cart.find(item => item.productoId === productoId);
    if (existing) {
        existing.cantidad++;
        existing.subtotal = existing.cantidad * existing.precioUnitario;
    } else {
        cart.push({ productoId, nombre, precioUnitario: precio, cantidad: 1, subtotal: precio });
    }
    renderCart();
}

function renderCart() {
    const container = document.getElementById('cartItems');
    if (cart.length === 0) {
        container.innerHTML = '<div class="empty-state"><p>Agrega productos al pedido</p></div>';
    } else {
        container.innerHTML = cart.map((item, i) => `
            <div class="cart-item" data-index="${i}">
                <div class="cart-item-info">
                    <h5>${item.nombre}</h5>
                    <span>${formatMoney(item.precioUnitario)} c/u</span>
                </div>
                <div class="cart-item-actions">
                    <button class="qty-btn qty-minus" data-index="${i}">-</button>
                    <span>${item.cantidad}</span>
                    <button class="qty-btn qty-plus" data-index="${i}">+</button>
                    <button class="qty-btn qty-remove" data-index="${i}">&times;</button>
                </div>
                <span style="font-weight:600;min-width:70px;text-align:right">${formatMoney(item.subtotal)}</span>
            </div>
        `).join('');
    }
    updateCartTotal();
}

document.getElementById('cartItems').addEventListener('click', (e) => {
    const btn = e.target.closest('.qty-btn');
    if (!btn) return;
    const index = parseInt(btn.dataset.index);
    if (btn.classList.contains('qty-minus')) {
        changeQty(index, -1);
    } else if (btn.classList.contains('qty-plus')) {
        changeQty(index, 1);
    } else if (btn.classList.contains('qty-remove')) {
        removeFromCart(index);
    }
});

function changeQty(index, delta) {
    cart[index].cantidad += delta;
    if (cart[index].cantidad <= 0) cart.splice(index, 1);
    else cart[index].subtotal = cart[index].cantidad * cart[index].precioUnitario;
    renderCart();
}

function removeFromCart(index) {
    cart.splice(index, 1);
    renderCart();
}

function updateCartTotal() {
    const subtotal = cart.reduce((sum, item) => sum + item.subtotal, 0);
    const promocionId = document.getElementById('posPromocion').value;
    const promocion = allPromociones.find(p => p.Id == promocionId);
    const descuento = promocion ? (subtotal * promocion.porcentajeDescuento / 100) : 0;
    const total = subtotal - descuento;
    const totalText = descuento > 0
        ? `${formatMoney(subtotal)} - ${promocion.porcentajeDescuento}% = ${formatMoney(total)}`
        : formatMoney(total);
    document.getElementById('cartTotal').textContent = totalText;
}

document.getElementById('posPromocion').addEventListener('change', () => {
    updateCartTotal();
});

function limpiarCarrito() {
    cart = [];
    document.getElementById('posPromocion').value = '';
    renderCart();
}

async function loadPosPromociones() {
    try {
        const data = await apiGet('/promociones/vigentes');
        allPromociones = data;
        const sel = document.getElementById('posPromocion');
        sel.innerHTML = '<option value="">Sin promocion</option>';
        data.forEach(p => {
            sel.innerHTML += `<option value="${p.Id}">${p.nombre} (${p.porcentajeDescuento}%)</option>`;
        });
    } catch (e) {
        console.error('Error loading promociones:', e);
    }
}

async function confirmarPedido() {
    const sucursalId = document.getElementById('posSucursal').value;
    const empleadoId = document.getElementById('posEmpleado').value;
    const clienteId = document.getElementById('posCliente').value || null;
    const promocionId = document.getElementById('posPromocion').value || null;
    const tipoPedido = document.getElementById('posTipo').value;

    if (!sucursalId) {
        showToast('Selecciona una sucursal', 'error');
        return;
    }
    if (!empleadoId) {
        showToast('Selecciona un empleado', 'error');
        return;
    }
    if (cart.length === 0) {
        showToast('Agrega al menos un producto', 'error');
        return;
    }

    try {
        const result = await apiPost('/pedidos', {
            sucursalId: parseInt(sucursalId),
            empleadoId: parseInt(empleadoId),
            clienteId: clienteId ? parseInt(clienteId) : null,
            promocionId: promocionId ? parseInt(promocionId) : null,
            tipoPedido: tipoPedido
        });
        const pedidoId = result.id;

        for (const item of cart) {
            await apiPost(`/pedidos/${pedidoId}/productos`, {
                productoId: item.productoId,
                cantidad: item.cantidad
            });
        }

        if (promocionId) {
            await apiPost(`/pedidos/${pedidoId}/promocion`, { promocionId: parseInt(promocionId) });
        }

        showToast(`Pedido #${pedidoId} creado exitosamente`);
        limpiarCarrito();
        cargarPedidos();
    } catch (e) {
        showToast(e.message, 'error');
    }
}

// ==================== PEDIDOS ====================
async function cargarPedidos() {
    const estatus = document.querySelector('#orderFilters .status-btn.active')?.dataset.status || '';
    const sucursalId = document.getElementById('pedidosSucursal').value;
    const fechaInicio = document.getElementById('pedidosFechaInicio').value;
    const fechaFin = document.getElementById('pedidosFechaFin').value;

    let url = `/pedidos?estatus=${estatus}`;
    if (sucursalId) url += `&sucursalId=${sucursalId}`;
    if (fechaInicio) url += `&fechaInicio=${fechaInicio}`;
    if (fechaFin) url += `&fechaFin=${fechaFin}`;

    const data = await apiGet(url);

    document.getElementById('pedidosTable').innerHTML = data.length === 0
        ? '<tr><td colspan="9" class="empty-state">No hay pedidos</td></tr>'
        : data.map(p => {
            const statusBadge = {
                'pendiente': 'badge-warning',
                'preparando': 'badge-info',
                'listo': 'badge-success',
                'entregado': 'badge-secondary',
                'cancelado': 'badge-danger'
            }[p.estatus] || 'badge-secondary';

            let actions = `<button class="btn btn-info btn-sm" onclick="verPedido(${p.Id})">Ver</button>`;
            if (p.estatus === 'pendiente') actions += ` <button class="btn btn-warning btn-sm" onclick="cambiarEstatus(${p.Id}, 'preparando')">Preparar</button>`;
            if (p.estatus === 'preparando') actions += ` <button class="btn btn-success btn-sm" onclick="cambiarEstatus(${p.Id}, 'listo')">Listo</button>`;
            if (p.estatus === 'listo') actions += ` <button class="btn btn-info btn-sm" onclick="cambiarEstatus(${p.Id}, 'entregado')">Entregar</button>`;
            if (['pendiente', 'preparando'].includes(p.estatus)) actions += ` <button class="btn btn-danger btn-sm" onclick="cancelarPedido(${p.Id})">Cancelar</button>`;

            return `
                <tr>
                    <td>#${p.Id}</td>
                    <td>${p.sucursal}</td>
                    <td>${p.empleado}</td>
                    <td>${p.cliente || 'Publico General'}</td>
                    <td>${formatDate(p.fechaHora)}</td>
                    <td>${p.tipoPedido}</td>
                    <td><span class="badge ${statusBadge}">${p.estatus}</span></td>
                    <td>${formatMoney(p.total)}</td>
                    <td>${actions}</td>
                </tr>
            `;
        }).join('');
}

async function cambiarEstatus(pedidoId, nuevoEstatus) {
    try {
        await apiPatch(`/pedidos/${pedidoId}/estatus`, { nuevoEstatus });
        showToast(`Pedido #${pedidoId} -> ${nuevoEstatus}`);
        cargarPedidos();
    } catch (e) { showToast(e.message, 'error'); }
}

async function cancelarPedido(pedidoId) {
    if (!confirm('Cancelar este pedido?')) return;
    try {
        await apiPatch(`/pedidos/${pedidoId}/cancelar`, {});
        showToast(`Pedido #${pedidoId} cancelado`);
        cargarPedidos();
    } catch (e) { showToast(e.message, 'error'); }
}

async function cancelarVencidos() {
    try {
        const result = await apiPost('/pedidos/cancelar-vencidos', {});
        showToast(`${result.cancelados} pedidos cancelados`);
        cargarPedidos();
    } catch (e) { showToast(e.message, 'error'); }
}

async function verPedido(pedidoId) {
    const data = await apiGet(`/pedidos/${pedidoId}`);
    const p = data.pedido;
    const detalle = data.detalle;

    const subtotal = detalle.reduce((sum, d) => sum + d.subtotal, 0);
    const promocionHtml = p.promocion
        ? `<div><strong>Promocion:</strong> ${p.promocion} (${p.porcentajeDescuento}%)</div>`
        : '';

    document.getElementById('orderDetailBody').innerHTML = `
        <div class="form-row" style="margin-bottom:1rem">
            <div><strong>Pedido:</strong> #${p.Id}</div>
            <div><strong>Sucursal:</strong> ${p.sucursal}</div>
            <div><strong>Empleado:</strong> ${p.empleado}</div>
            <div><strong>Cliente:</strong> ${p.cliente || 'Publico General'}</div>
        </div>
        <div class="form-row" style="margin-bottom:1rem">
            <div><strong>Fecha:</strong> ${formatDate(p.fechaHora)}</div>
            <div><strong>Tipo:</strong> ${p.tipoPedido}</div>
            <div><strong>Estatus:</strong> <span class="badge badge-info">${p.estatus}</span></div>
        </div>
        ${promocionHtml ? `<div style="margin-bottom:1rem;padding:0.5rem;background:var(--success);color:#fff;border-radius:var(--radius)"><strong>Promocion aplicada:</strong> ${p.promocion} (-${p.porcentajeDescuento}%)</div>` : ''}
        <h4 style="margin:1rem 0 0.5rem">Detalle</h4>
        <table>
            <thead><tr><th>Producto</th><th>Cantidad</th><th>Precio Unit.</th><th>Subtotal</th></tr></thead>
            <tbody>
                ${detalle.map(d => `
                    <tr>
                        <td>${d.producto}</td>
                        <td>${d.cantidad}</td>
                        <td>${formatMoney(d.precioUnitario)}</td>
                        <td>${formatMoney(d.subtotal)}</td>
                    </tr>
                `).join('')}
            </tbody>
        </table>
        <div style="text-align:right;margin-top:1rem;font-size:1.3rem;font-weight:700;color:var(--primary)">
            Total: ${formatMoney(p.total)}
        </div>
    `;
    document.getElementById('orderDetailOverlay').classList.add('active');
}

// ==================== DASHBOARD ====================
async function cargarDashboard() {
    const fechaInicio = document.getElementById('dashFechaInicio').value;
    const fechaFin = document.getElementById('dashFechaFin').value;
    const sucursalId = document.getElementById('dashSucursal').value;

    let params = '';
    if (fechaInicio) params += `fechaInicio=${fechaInicio}&`;
    if (fechaFin) params += `fechaFin=${fechaFin}&`;
    if (sucursalId) params += `sucursalId=${sucursalId}&`;

    try {
        const ventasSucursal = await apiGet(`/reportes/ventas-sucursal?${params}`);
        const topProductos = await apiGet(`/reportes/productos-vendidos?${params}top=10`);
        const ventasCategoria = await apiGet(`/reportes/ventas-categoria?${params}`);
        const rendimiento = await apiGet(`/reportes/rendimiento-empleados?${params}`);
        const sinMovimiento = await apiGet(`/reportes/productos-sin-movimiento?${params}`);
        const comparativo = await apiGet(`/reportes/comparativo-mensual?anio=${new Date().getFullYear()}`);

        const totalVentas = ventasSucursal.reduce((s, v) => s + Number(v.totalVentas), 0);
        const totalPedidos = ventasSucursal.reduce((s, v) => s + Number(v.totalPedidos), 0);
        const ticketPromedio = totalPedidos > 0 ? totalVentas / totalPedidos : 0;
        const sucursalTop = ventasSucursal.length > 0 ? ventasSucursal.reduce((a, b) => Number(a.totalVentas) > Number(b.totalVentas) ? a : b) : null;

        document.getElementById('dashTotalVentas').textContent = formatMoney(totalVentas);
        document.getElementById('dashTotalPedidos').textContent = `${totalPedidos} pedidos`;
        document.getElementById('dashTicketPromedio').textContent = formatMoney(ticketPromedio);
        document.getElementById('dashSucursalTop').textContent = sucursalTop ? `${sucursalTop.sucursal} (${sucursalTop.ciudad})` : '-';

        renderBarChart('chartSucursales', ventasSucursal.map(v => ({ label: v.sucursal, value: Number(v.totalVentas) })));
        renderBarChart('chartCategorias', ventasCategoria.map(v => ({ label: v.categoria, value: Number(v.totalVentas) })));

        document.getElementById('dashTopProductos').innerHTML = topProductos.length > 0 ? topProductos.map((p, i) => `
            <tr>
                <td>${i + 1}</td>
                <td>${p.producto}</td>
                <td>${p.categoria}</td>
                <td>${p.cantidadVendida}</td>
                <td>${formatMoney(p.totalVentas)}</td>
            </tr>
        `).join('') : '<tr><td colspan="5" class="empty-state">Sin datos</td></tr>';

        document.getElementById('dashEmpleados').innerHTML = rendimiento.length > 0 ? rendimiento.map(e => `
            <tr>
                <td>${e.empleado}</td>
                <td>${e.puesto}</td>
                <td>${e.sucursal}</td>
                <td>${e.totalPedidos}</td>
                <td>${formatMoney(e.totalVentas)}</td>
                <td>${formatMoney(e.ticketPromedio)}</td>
            </tr>
        `).join('') : '<tr><td colspan="6" class="empty-state">Sin datos</td></tr>';

        document.getElementById('dashSinMovimiento').innerHTML = sinMovimiento.length > 0 ? sinMovimiento.map(p => `
            <tr><td>${p.producto}</td><td>${p.categoria}</td></tr>
        `).join('') : '<tr><td colspan="2" class="empty-state">Todos los productos tienen ventas</td></tr>';

        const meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
        document.getElementById('dashComparativo').innerHTML = comparativo.length > 0 ? comparativo.map(c => `
            <tr>
                <td>${c.anio}</td>
                <td>${meses[c.mes - 1]}</td>
                <td>${c.sucursal}</td>
                <td>${c.totalPedidos}</td>
                <td>${formatMoney(c.totalVentas)}</td>
            </tr>
        `).join('') : '<tr><td colspan="5" class="empty-state">Sin datos</td></tr>';

    } catch (e) {
        showToast('Error cargando dashboard: ' + e.message, 'error');
    }
}

function renderBarChart(containerId, data) {
    const container = document.getElementById(containerId);
    if (data.length === 0) {
        container.innerHTML = '<div class="empty-state">Sin datos</div>';
        return;
    }
    const max = Math.max(...data.map(d => d.value), 1);
    container.innerHTML = data.map(d => `
        <div class="bar" style="height:${(d.value / max) * 100}%">
            <div class="bar-value">${formatMoney(d.value)}</div>
            <div class="bar-label">${d.label}</div>
        </div>
    `).join('');
}

// ==================== INIT ====================
async function init() {
    await loadSucursales();
    await loadCategorias();
    await loadEmpleados();
    await loadClientes();
    await loadProductos();
    loadPosProducts();
    await loadPromociones();
    await loadPedidos();
    setDefaultDates();
    populateEmpleadoSelect();
    populateClienteSelect();
}

init();

-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Gisella Caballero
-- Fecha: 18/11/2026
-- Motor: SQL Server (SSMS)
-- ══════════════════════════════════════════


-- ── SECCIÓN DDL ──────────────────────────
-- DDL (Data Definition Language): define la ESTRUCTURA de la tabla.

-- DROP TABLE
-- Elimina la tabla si ya existe, para poder re-ejecutar el script
-- completo sin el error "la tabla ya existe".
DROP TABLE IF EXISTS inventario;


-- CREATE TABLE
CREATE TABLE inventario (
    -- INT: identificador numérico entero.
    -- PRIMARY KEY: cada producto se identifica de forma única y no admite NULL.
    id_producto      INT            NOT NULL PRIMARY KEY,

    -- VARCHAR(100): texto de largo variable; solo ocupa el espacio que usa.
    nombre_producto  VARCHAR(100)   NOT NULL,

    -- VARCHAR(50): las categorías son nombres cortos (Computación, Audio...).
    categoria        VARCHAR(50)    NOT NULL,

    -- DECIMAL(10,2): precio en USD con 2 decimales exactos.
    -- Nunca FLOAT para dinero: FLOAT es aproximado y genera errores de redondeo.
    precio_unitario  DECIMAL(10,2)  NOT NULL,

    -- INT: el stock se cuenta en unidades enteras (no hay medio mouse).
    stock_actual     INT            NOT NULL,

    -- INT: umbral de reposición, también en unidades enteras.
    stock_minimo     INT            NOT NULL,

    -- DATE: solo interesa el día de ingreso, no la hora.
    fecha_ingreso    DATE           NOT NULL,

    -- BIT: 1 = disponible, 0 = descontinuado.
    -- La consigna sugiere TINYINT(1), pero esa sintaxis es de MySQL y da error
    -- en SQL Server. BIT es el equivalente booleano de SQL Server: solo admite
    -- 0 o 1, así que no puede cargarse un valor inválido como 5.
    -- DEFAULT 1: si no se indica, el producto nace activo.
    activo           BIT            NOT NULL DEFAULT 1
);


-- ── SECCIÓN DML ──────────────────────────
-- DML (Data Manipulation Language): carga y modifica los DATOS.

-- INSERT INTO
-- Se nombran las columnas explícitamente para que el orden de los valores
-- no dependa del orden de definición de la tabla.
INSERT INTO inventario
    (id_producto, nombre_producto, categoria, precio_unitario,
     stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES
    (1,  'Laptop Pro 15',       'Computación',    1200.00, 15, 3,  '2024-01-10', 1),
    (2,  'Mouse Inalámbrico',   'Accesorios',       28.00, 80, 10, '2024-01-10', 1),
    (3,  'Monitor 4K 27"',      'Computación',     450.00, 12, 2,  '2024-01-15', 1),
    (4,  'Teclado Mecánico',    'Accesorios',       95.00, 40, 5,  '2024-01-15', 1),
    (5,  'Laptop Basic 14',     'Computación',     650.00, 20, 3,  '2024-02-01', 1),
    (6,  'Auriculares BT Pro',  'Audio',           120.00, 35, 5,  '2024-02-01', 1),
    (7,  'Hub USB-C 7 puertos', 'Accesorios',       45.00, 60, 10, '2024-02-10', 1),
    (8,  'Webcam HD 1080p',     'Accesorios',       85.00, 25, 5,  '2024-02-10', 1),
    (9,  'SSD Externo 1TB',     'Almacenamiento',  130.00, 18, 3,  '2024-03-01', 1),
    (10, 'Parlante Bluetooth',  'Audio',            60.00, 45, 8,  '2024-03-01', 1);


-- UPDATE ventas del día
-- Se resta lo vendido al stock existente (stock_actual - unidades) en lugar
-- de escribir el número final, así el script refleja la operación real.
-- Cada UPDATE lleva WHERE id_producto = X: sin WHERE se modificaría el stock
-- de TODOS los productos.

-- Laptop Pro 15: vendidas 3 unidades (15 → 12)
UPDATE inventario
SET    stock_actual = stock_actual - 3
WHERE  id_producto = 1;

-- Mouse Inalámbrico: vendidas 12 unidades (80 → 68)
UPDATE inventario
SET    stock_actual = stock_actual - 12
WHERE  id_producto = 2;

-- Auriculares BT Pro: vendidas 5 unidades (35 → 30)
UPDATE inventario
SET    stock_actual = stock_actual - 5
WHERE  id_producto = 6;


-- UPDATE producto descontinuado
-- Webcam HD 1080p descontinuada por el proveedor: se marca inactiva.
-- No se borra (DELETE) para conservar el historial del producto.
UPDATE inventario
SET    activo = 0
WHERE  id_producto = 8;


-- SELECT validaciones
-- Ver la tabla completa para confirmar que los datos se cargaron.
-- Resultado esperado: 10 productos; Laptop Pro 15 = 12, Mouse = 68,
-- Auriculares = 30 y Webcam HD 1080p con activo = 0.
SELECT * FROM inventario;

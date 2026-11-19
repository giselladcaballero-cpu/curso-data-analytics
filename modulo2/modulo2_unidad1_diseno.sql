-- =====================================================================
-- Módulo 2 · Unidad 1 — Diseño de tablas del sistema de gestión de ventas
-- Autora: Gisella Caballero
-- Motor: SQL Server (el motor del curso)
-- Objetivo: definir la estructura de las tablas clientes y productos.
-- =====================================================================


-- ---------------------------------------------------------------------
-- Tabla: clientes
-- Guarda una fila por cada cliente del sistema.
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    -- INT: el identificador es un número entero, no lleva decimales
    -- y alcanza para más de 2.000 millones de clientes.
    -- PRIMARY KEY: identifica cada fila de forma única y no admite NULL.
    id_cliente      INT             NOT NULL PRIMARY KEY,

    -- VARCHAR(100): el nombre es texto de largo variable; con 100
    -- caracteres alcanza y solo ocupa el espacio que realmente se usa.
    -- NOT NULL: todo cliente debe tener nombre.
    nombre          VARCHAR(100)    NOT NULL,

    -- VARCHAR(MAX): texto largo para la biografía o notas, sin un límite
    -- fijo de caracteres (en SQL Server se usa VARCHAR(MAX) en lugar del
    -- tipo TEXT, que está obsoleto). Admite NULL porque es opcional.
    perfil_bio      VARCHAR(MAX)    NULL,

    -- DATE: solo se necesita el día del alta, no la hora.
    fecha_registro  DATE            NOT NULL
);


-- ---------------------------------------------------------------------
-- Tabla: productos
-- Guarda una fila por cada producto que vende el negocio.
-- ---------------------------------------------------------------------
CREATE TABLE productos (
    -- INT: identificador numérico entero del producto.
    -- PRIMARY KEY: único y obligatorio para cada producto.
    id_producto     INT             NOT NULL PRIMARY KEY,

    -- VARCHAR(255): descripción de largo variable de hasta 255 caracteres.
    descripcion     VARCHAR(255)    NOT NULL,

    -- DECIMAL(10,2): hasta 10 dígitos en total, 2 de ellos decimales
    -- (máximo 99.999.999,99). Se usa DECIMAL y no FLOAT porque FLOAT es
    -- aproximado y puede generar errores de redondeo con dinero.
    precio          DECIMAL(10,2)   NOT NULL,

    -- BIT: guarda solo 1 (activo / a la venta) o 0 (inactivo). Ocupa
    -- menos espacio que un texto ("Sí"/"No") y evita valores ambiguos
    -- como "si", "SI" o "activo". En otros motores el equivalente es
    -- BOOLEAN. DEFAULT 1: si no se indica, el producto nace activo.
    esta_activo     BIT             NOT NULL DEFAULT 1
);

-- Motor utilizado: SQL Server (SSMS)
-- ==========================================
-- M4 - Consultas SQL de negocio sobre Ventas_Tech_DB (creada en M3)
-- Proyecto RetailPro
-- Autora: Gisella Caballero
-- ==========================================

USE Ventas_Tech_DB;
GO


-- === CONSULTA 1: Resumen ejecutivo mensual ===
-- Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
-- Con los datos cargados en M3 todas las ventas son de marzo de 2024,
-- por eso el resultado esperado es una sola fila (mes = 3).
-- En PostgreSQL: reemplazar MONTH(fecha_venta) por EXTRACT(MONTH FROM fecha_venta).
SELECT
    MONTH(fecha_venta)                      AS mes,
    SUM(cantidad * precio_unitario)         AS total_facturado,
    COUNT(*)                                AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)         AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);
GO


-- === CONSULTA 2: Ranking de productos ===
-- Top 5 de id_producto por total facturado, con las unidades vendidas.
SELECT TOP 5
    id_producto,
    SUM(cantidad)                           AS unidades_vendidas,
    SUM(cantidad * precio_unitario)         AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO


-- === CONSULTA 3: Clientes recurrentes ===
-- id_cliente con más de un pedido, con la cantidad de pedidos y el total gastado.
SELECT
    id_cliente,
    COUNT(*)                                AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)         AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;
GO


-- === CONSULTA 4: Productos por encima/por debajo del promedio ===
-- Total facturado por producto, comparado contra el promedio de esos totales
-- (el promedio de los totales por producto, no el promedio de las filas de ventas).
WITH facturacion_por_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
),
promedio_facturacion AS (
    SELECT AVG(total_facturado) AS promedio
    FROM facturacion_por_producto
)
SELECT
    f.id_producto,
    f.total_facturado,
    CASE
        WHEN f.total_facturado > p.promedio THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_por_producto f
CROSS JOIN promedio_facturacion p
ORDER BY f.total_facturado DESC;
GO


-- === HALLAZGOS ===
-- 1. El producto 1 concentra $3.600 de los $6.444 facturados en el trimestre
--    (~56% del total), la mayor participación de todos los productos.
-- 2. Los 5 clientes de la base son recurrentes: cada uno hizo exactamente
--    2 pedidos en el período, no hay compradores de una sola vez en esta muestra.
-- 3. Solo 2 de los 6 productos (id_producto 1 y 3) quedan "Por encima" del
--    promedio de facturación por producto ($1.074); los otros 4 quedan
--    "Por debajo", lo que muestra que la facturación está concentrada en pocos productos.

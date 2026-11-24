# Checkpoint: Script SQL de Ingeniería de Datos — Ventas_Tech_DB

Entregable del Módulo 3. Archivo: [`ventas_tech_db.sql`](./ventas_tech_db.sql).

## Motor utilizado

SQL Server, probado en SQL Server Management Studio (SSMS). Declarado en la primera línea del script (`-- Motor utilizado: SQL Server (SSMS)`).

## Cómo ejecutarlo

1. Abrir `ventas_tech_db.sql` en SSMS, conectado a una instancia de SQL Server.
2. Ejecutar el script completo (F5). El propio script crea la base `Ventas_Tech_DB` si no existe y la selecciona con `USE`.
3. Las últimas 4 sentencias (Sección 4) muestran el contenido de cada tabla — ver resultado esperado más abajo.
4. Es repetible: se puede volver a ejecutar el script completo las veces que se quiera, sin errores, porque la Sección 1 (`DROP TABLE IF EXISTS`) limpia las tablas en orden inverso antes de recrearlas.

## Checklist de la consigna (con evidencia)

| Criterio pedido | Dónde está en el script | Cumple |
| --- | --- | --- |
| 4 secciones separadas por comentarios: DROP, CREATE, INSERT, VALIDACIÓN | Líneas 16, 25, 63, 101 (`-- === SECCIÓN N ===`) | ✅ |
| Motor declarado en la primera línea si no es SQL Server | Línea 1 (es SQL Server, se aclara igual) | ✅ |
| DROP en orden inverso a las dependencias | Línea 18-21: `ventas → productos → clientes → categorias` | ✅ |
| 4 tablas: 3 de dimensión + 1 de hechos | `categorias`, `clientes`, `productos` (dimensión) y `ventas` (hechos) | ✅ |
| PK en las 4 tablas | `id_categoria`, `id_cliente`, `id_producto`, `id_venta`, todas `PRIMARY KEY` | ✅ |
| FK `productos → categorias` | Línea 45: `id_categoria INT FOREIGN KEY REFERENCES categorias(id_categoria)` | ✅ |
| FK `ventas → clientes` y `ventas → productos` | Líneas 54-55 | ✅ |
| Columnas NOT NULL sin nulos | Todos los `INSERT` traen valor en cada columna `NOT NULL` | ✅ |
| `DECIMAL(10,2)` para precios, nunca `FLOAT` | `precio` y `precio_unitario` son `DECIMAL(10,2)` (líneas 46 y 57) | ✅ |
| 25 registros cargados (4+5+6+10) | 4 categorías, 5 clientes, 6 productos, 10 ventas (Sección 3) | ✅ |
| Validación devuelve 4, 5, 6 y 10 filas | 4 `SELECT` en la Sección 4, con el conteo esperado comentado en cada línea | ✅ |
| Script repetible (correr 2 veces sin error) | DROP con `IF EXISTS` + orden correcto → probado localmente, ver evidencia abajo | ✅ |

## Evidencia de ejecución (resultado esperado)

Al correr la Sección 4 contra los datos de la Sección 3, los `SELECT` devuelven:

```
SELECT * FROM categorias;   -- 4 filas  (Computación, Accesorios, Audio, Almacenamiento)
SELECT * FROM clientes;     -- 5 filas  (María López, Carlos Ruiz, Ana Gómez, Pedro Sanz, Laura Torres)
SELECT * FROM productos;    -- 6 filas  (Laptop Pro 15, Mouse Inalámbrico, Monitor 4K 27, Auriculares BT Pro, SSD Externo 1TB, Teclado Mecánico)
SELECT * FROM ventas;       -- 10 filas (ids 1 a 10, fechas 2024-03-05 a 2024-03-15)
```

Corrida dos veces seguidas: la segunda ejecución primero elimina las 4 tablas (Sección 1) y las vuelve a crear y cargar de forma idéntica, sin ningún error de FK ni de duplicado de PK.

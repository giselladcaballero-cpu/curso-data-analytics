# Ventas_Tech_DB

Script SQL de ingeniería de datos para TechStore, una cadena de tiendas de tecnología.

## Contenido

`modulo3/ventas_tech_db.sql` crea la base `Ventas_Tech_DB` con un modelo relacional en 3NF:

```
categorias (1) ──── (N) productos (1) ──── (N) ventas (N) ──── (1) clientes
```

El script está dividido en cuatro secciones:

1. **DROP** — elimina las tablas si existen, en orden inverso a las dependencias (repetible).
2. **CREATE** — crea las cuatro tablas (`categorias`, `clientes`, `productos`, `ventas`) con sus primary keys y foreign keys.
3. **INSERT** — carga 25 registros: 4 categorías, 5 clientes, 6 productos y 10 ventas.
4. **VALIDACIÓN** — cuatro `SELECT` que confirman la cantidad de filas cargadas.

## Motor

SQL Server (SSMS). Los precios usan `DECIMAL(10,2)` en vez de `FLOAT` para evitar errores de redondeo.

## Cómo correrlo

Abrir el archivo en SQL Server Management Studio (SSMS) y ejecutarlo completo. Es repetible: se puede correr varias veces sin errores.

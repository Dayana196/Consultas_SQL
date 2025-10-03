USE `ecommerce_zapatos`;
SELECT `pedido_id`, `producto_id`, `cantidad` FROM `PedidoProductoCompuesta`
WHERE `pedido_id` = 1;

SELECT * FROM `Usuarios`;
SELECT * FROM `Pedidos`;
SELECT * FROM `PedidoProducto`
WHERE `pedido_id` = 1;

SELECT `pedido_id`, `producto_id`, `cantidad` FROM `PedidoProducto`
WHERE `pedido_id` = 1;

SELECT u.*, p.*
FROM `Usuarios` as u, `Pedidos` p
WHERE u.usuarios_id = p.usuarios_id;

SELECT u.correo, p.fecha_pedido, p.pedidos_id, pr.nombre, pr.precio_unitario, pr.precio_venta
FROM `Usuarios` as u
INNER JOIN `Pedidos` p ON u.usuarios_id = p.usuarios_id
INNER JOIN `PedidoProducto` pp ON p.pedidos_id = pp.pedido_id
INNER JOIN `Productos` pr ON pp.producto_id = pr.producto_id;

SELECT u.correo, p.pedidos_id, p.fecha_pedido, SUM(pp.cantidad) as 'total_items'
FROM `Usuarios` as u
INNER JOIN `Pedidos` p ON u.usuarios_id = p.usuarios_id
INNER JOIN `PedidoProducto` as pp ON p.pedidos_id = pp.pedido_id
WHERE u.correo = 'dayana@gmail.com'
GROUP BY p.pedidos_id;

SELECT u.correo, p.pedidos_id, p.fecha_pedido, SUM(pp.cantidad) as 'total_items', pr.nombre
FROM `Usuarios` as u
INNER JOIN `Pedidos` p ON u.usuarios_id = p.usuarios_id
INNER JOIN `PedidoProducto` as pp ON p.pedidos_id = pp.pedido_id
INNER JOIN `Productos` as pr ON pp.producto_id = pr.producto_id
WHERE u.correo = 'dayana@gmail.com'
GROUP BY p.pedidos_id, pr.nombre;

-- se requiere obtener el total de cada money de cada pedido realizado por nuestros usuairos

-- se requiere saber la cantidad totqal de productos vendidos en una fecha especifico

-- se requiere saber la cantidad de zapatos deportidos vendidos enh un rango especifico [BETWEEN date1 AND date2] 


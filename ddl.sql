CREATE DATABASE IF NOT EXIST `ecommerce_zapatos`;

USE `ecommerce_zapatos`;

CREATE TABLE `Usuarios` (
    `usuarios_id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(50) DEFAULT NULL,
    `apellido` varchar(50) DEFAULT NULL,
    `correo` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`usuarios_id`)
);

CREATE TABLE `Pedidos` (
    `pedidos_id` int NOT NULL AUTO_INCREMENT,
    `usuarios_id` int DEFAULT NULL,
    `fecha_pedido` date DEFAULT NULL,
    `total` decimal(10,2) DEFAULT NULL,
    PRIMARY KEY (`pedidos_id`),
    KEY `usuarios_id` (`usuarios_id`),
    CONSTRAINT `Pedidos_ibfk_1` FOREIGN KEY (`usuarios_id`)
    REFERENCES `Usuarios` (`usuarios_id`)
);

INSERT INTO  `Usuarios` (`correo`,`apellido`, `nombre`) VALUES
('dayana@gmail.com', 'Barbosa', 'Dayana'),
('marcela@gmail.com', 'Lopez', 'Marcela'),
('sofia@gmail.com', 'Gomez', 'Sofia'),
('michelf@gmail.com', 'Martinez', 'Michel'),
('santiv@gmail.com', 'Villamil', 'Santiago');

SELECT * FROM `Usuarios`;

INSERT INTO `Pedidos` (`usuarios_id`, `fecha_pedido`, `total`) VALUES
(1, '2023-10-01', 150.00),
(2, '2023-10-02', 200.00),
(1, '2023-10-03', 50.25),
(3, '2023-10-04', 300.40),
(4, '2023-10-05', 120.00),
(5, '2023-10-06', 80.90);

SELECT * FROM `Pedidos`;

CREATE TABLE `Productos` (
    `producto_id` INT AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `precio_unitario` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `precio_venta` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`producto_id`)
);

CREATE TABLE `PedidoProducto`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `pedido_id` INT NOT NULL,
    `producto_id` INT NOT NULL,
    `cantidad` INT NOT NULL DEFAULT 1,
    PRIMARY KEY(`id`)
);

ALTER TABLE `PedidoProducto` ADD FOREIGN KEY(`pedido_id`)
REFERENCES `Pedidos` (`pedidos_id`);

ALTER TABLE `PedidoProducto` ADD CONSTRAINT `Productos_producto_id_fk` FOREIGN KEY(`producto_id`) REFERENCES `Productos`(`producto_id`);

INSERT INTO `Productos`(`nombre`, `precio_unitario`, `precio_venta`) VALUES
('Zapato Deportivo', 75.00, 90.00),
('Zapato Casual', 60.00, 75.00),
('Bota de Cuero', 120.00, 150.00),
('Sandalia', 40.00, 55.00),
('Zapato Formal', 100.00, 130.00),
('Tenis', 80.00, 100.00),
('Mocasin', 70.00, 85.00),
('Botin', 110.00, 140.00),
('Zapatilla', 50.00, 65.00),
('Alpargata', 30.00, 45.00);

INSERT INTO `PedidoProducto`(`pedido_id`, `producto_id`, `cantidad`) VALUES
(1, 1, 5),
(1, 1, 2),
(1, 3, 1),
(1, 1, 1),
(2, 5, 1),
(3, 4, 3),
(1, 1, 2),
(4, 7, 1),
(5, 8, 1),
(5, 9, 2),
(6, 10, 1);


SELECT * FROM `Usuarios`;
SELECT * FROM `Pedidos`;
SELECT * FROM `PedidoProducto`
WHERE `Pedido_id` = 1;



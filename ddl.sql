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

CREATE TABLE `Productos`(
    `producto_id` INT AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `precio_unitario` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `precio_venta` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`producto_id`)
);

CREATE TABLE `PedidoProductoCompuesta`(
    `pedido_id` INT NOT NULL,
    `producto_id` INT NOT NULL,
    `cantidad` INT NOT NULL DEFAULT 1,
    PRIMARY KEY(`pedido_id`, `producto_id`),
    FOREIGN KEY(`pedido_id`) REFERENCES `Pedidos`(`pedido_id`),
    FOREIGN KEY(`producto_id`) REFERENCES `Productos`(`producto_id`)
);

-- procedures 
DELIMITER $$ 

CREATE PROCEDURE hello_world(IN p_nombre VARCHAR(100))
BEGIN 
    SELECT CONCAT('HOLIIII : ', p_nombre) AS saludo;
END$$

DELIMITER ;

--LLAMADO
CALL nombre_procedura (...)

DELIMITER // 

CREATE PROCEDURE calcular_empleado(IN p_ventas DECIMAL(10,2))
BEGIN
    IF p_ventas >= 100000 THEN 
        SELECT 'El empleado cumplio con las ventas' as resultado;
    ELSEIF p_ventas >= 50000 THEN 
        SELECT 'El empleado CASI cumplio con las ventas' as resultado;
    ELSE 
        SELECT 'El empleado NOOOOOO cumplio con las ventas' as resultado;
    END IF; 
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE mostrar_top_ventas(IN p_min DECIMAL(10,2), IN p_max DECIMAL(10,2))
BEGIN
    SELECT * FROM pedidos WHERE total BETWEEN p_min AND p_max;
END// 

DELIMITER ;
CALL mostrar_top_ventas(40.00, 100.00);

CREATE TABLE Cupones(
cupon_id INT AUTO_INCREMENT,
descuento DECIMAL(5,2) NOT NULL CHECK(descuento > 0 AND descuento <= 100),
usuario_id_fk INT NOT NULL,
PRIMARY KEY(cupon_id),
FOREIGN KEY(usuario_id_fk) REFERENCES Usuarios(usuario_id)
);

-- DROP VIEW vw_.....
CREATE OR REPLACE VIEW vw_top_clientes_compras AS
SELECT CONCAT_WS(' ',u.apellido,u.nombre) as nombres, u.usuario_id, SUM(p.total) as total_pedidos, COUNT(p.pedido_id) as cantidad_pedidos, GROUP_CONCAT(p.fecha_pedido) as fechas
FROM Pedidos p
INNER JOIN Usuarios u ON p.usuario_id_fk = u.usuario_id
GROUP BY u.usuario_id ORDER BY total_pedidos DESC;

DELIMITER //
DROP PROCEDURE IF EXISTS aplicar_cupon_usuario//
CREATE PROCEDURE aplicar_cupon_usuario(IN p_total_min DECIMAL(10,2), IN p_cantidad_min INT, IN p_descuento DECIMAL(5,2))
BEGIN -- AYYY JUANDiiii
DECLARE fin INT DEFAULT 0;
DECLARE v_total_pedidos DECIMAL(10,2) DEFAULT 0.00;
DECLARE v_usuario_id INT DEFAULT 0;
DECLARE v_nombres VARCHAR(200) DEFAULT "";
DECLARE v_cantidad_pedidos INT DEFAULT 0;
DECLARE v_fechas VARCHAR(200) DEFAULT "";
DECLARE cur CURSOR FOR SELECT nombres, usuario_id, total_pedidos, cantidad_pedidos, fechas FROM vw_top_clientes_compras;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
-- Abrir el CURSOR
OPEN cur;
registros : LOOP
    FETCH cur INTO v_nombres, v_usuario_id, v_total_pedidos, v_cantidad_pedidos, v_fechas;
    IF fin = 1 THEN LEAVE registros; END IF;

    CASE 
    WHEN  v_total_pedidos >= p_total_min THEN
        INSERT INTO Cupones(descuento, usuario_id_fk) VALUES(p_descuento, v_usuario_id);
    ELSE
        SELECT CONCAT_WS(': ','No se le asigno ningun cupon a', v_nombres)as Error;
    END CASE;
END LOOP registros;
-- Cerrar el CURSOR
CLOSE cur;
END 
//
DELIMITER ;

CALL aplicar_cupon_usuario(100.00, 0, 15.00);


--- CREAR UN PROCEDIMIENTO DE ALMACENADO QUE CREE N PEDIDOS PARA UN USUARIO X CON UN VALOR DE 0 Y ESTADO DE PREPARACION
-- HACIENDO USO DE WHILE
DELIMITER //
DROP PROCEDURE IF EXISTS crear_pedidos//
CREATE PROCEDURE crear_pedidos(IN p_usuario_id INT, IN p_n INT)
BEGIN
DECLARE i INT DEFAULT 1;

WHILE i <= p_n DO
    INSERT INTO Pedidos(usuario_id_fk, total)
    VALUES (p_usuario_id, 0.00);
    SET i = i + 1;
END WHILE;
END
//

DELIMITER ;

CALL crear_pedidos(2,5);

DELIMITER $$

DROP FUNCTION fn_total_pedido $$
RETURNS DECIMAL (10,2)
DETERMINISTIC 
BEGIN
    DECLARE v_total DECIMAL (10,2) DEFAULT 0.00;

    SELECT SUM (pp.cantidad * pr.precio_venta) INTO v_total FROM pedidos p  
    INNER JOIN PedidoProducto pp ON p.pedido = pp.pedido_id_fk 
    INNER JOIN Productos pr ON pp.producto_id_fk = pr.producto_id
    WHERE p.pedido_id = p_pedido_id

    RETURN v_total; 
END
$$

DELIMITER ; 

SELECT p.pedido_id,, p.fecha_pedido, fn_total_pedido(p.pedido_id) as TotalCalculado 
FROM pedidos P;

-- SE REQUIERE UNA FUNCION QUE RETORNE LA CANTIDAD DE DINERO EDE PEDIDOS POR UN RANGO DE FECHAS ESPECIFICOS.
-- SE REQUIERE UNA FUNCION PARA SABER LA CANTIDAD POR PRODUCTOIS VENDIDOS 
--DELIMITER $$
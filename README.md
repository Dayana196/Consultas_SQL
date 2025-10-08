# MYSQL - Apuntes






## Comandos - Terminal
- docker ps **-->** Visualizar  Reciente
- docker ps -a **-->** Visualizar todos los archivos 
- docker start **Nombre de archivo** **-->** Inicializa el archivo seleccionado
- docker exec -it mysql_container mysql -h localhost -u root -P 3306 -p **-->** Para entrar al Mysql 
    - mysql> SHOW DATABASES; **-->** Vializar los archivos que haz creado en mysql
    - mysql> CREATE DATABASE IF NOT EXISTS `ecommerce_zapatos`; **-->** Crea una base de datos si esta no existe
    - mysql> USE `ecommerce_zapatos`; **-->** Seleciona la base de dato
    ```
    CREATE TABLE `usuarios`(
        `usuarios_id` int NOT NULL AUTO_INCREMENT,
        `nombre` VARCHAR(50) DEFAULT NULL,
        `apellido` VARCHAR(50) DEFAULT NULL,
        `correo` VARCHAR(50) DEFAULT NULL,
        PRIMARY KEY (`usuarios_id`)
    );

    CREATE TABLE `pedidos` (
        `pedido_id` int NOT NULL AUTO_INCREMENT,
        `usuarios_id` int DEFAULT NULL,
        `fecha_pedido` date DEFAULT NULL,
        `total` decimal(10,2) DEFAULT NULL,
        PRIMARY KEY (`pedido_id`),
        KEY `usuarios_id` (`usuarios_id`),
        CONSTRAINT `Pedidos_ibfk_1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`usuarios_id`)
    );

    INSERT INTO `usuarios`(`correo`, `apellido`, `nombre`) VALUES
    ('cristiandres1317@gmial.com', 'Mayorga', 'Cristian'),
    ('adrian@gmail.com', 'Ruiz', 'Adrian'),
    ('Dayana12@gmail.com', 'Barbosa', 'Dayana'),
    ('SilviaLopez@gmail.com', 'Lopez', 'Silvia'),
    ('diegoTwis@gmail.com', 'Diaz', 'Diego');

    Para añadir la información a la tabla de pedidos
    ```
    - mysql> SELECT * FROM `usuarios` **-->** Visualizar la tabla **usuarios**
    - mysql> SHOW TABLES;  **-->** Visualizar Todas las Tablas creadas.

    ```
    INSERT INTO `pedidos` (`usuarios_id`, `fecha_pedido`, `total`) VALUES
    (1, '2023-10-01', 150.00),
    (2, '2023-10-02', 200.00),
    (1, '2023-10-03', 50.00),
    (3, '2023-10-04', 300.00),
    (4, '2023-10-05', 120.00),
    (5, '2023-10-06', 80.90); 

    Para añadir la información a la tabla de pedidos
    ```
    - mysql> SELECT * FROM `pedidos`;

    ```
    CREATE TABLE `Producto` (
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
    );  Tabla intermidiaria entre Pedido y Producto.

    ALTER TABLE `PedidoProducto` ADD FOREIGN KEY(`pedido_id`) REFERENCES `pedidos`(`pedido_id`); --> Relaciones que tienes una tabla con otra tabla

    ALTER TABLE `PedidoProducto` ADD CONSTRAINT `Productos_producto_id_fk` FOREIGN KEY(`producto_id`) REFERENCES `Productos`(`producto_id`); --> Relaciones que tienes una tabla con otra tabla

    INSERT INTO `Producto`(`nombre`, `precio_unitario`, `precio_venta`) VALUES
    ('Zapato Deportivo', 75.00, 90.00),
    ('Zapato Casual', 60.00, 75.00),
    ('Bota de Cuero', 120.00, 150.00),
    ('Sandalia', 40.00, 55.00),
    ('Zapato Formal', 100.00, 130.00),
    ('Tenis', 80.00, 100.00),
    ('Mocasin', 70.00, 85.00),
    ('Botin', 110.00, 140.00),
    ('Zapatilla', 50.00, 65.00),
    ('Alpargata', 30.00, 45.00); Insertar los Producto cada uno con su precio de venta, unitario y nombre.

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
    ```

    - mysql> SELECT * FROM `usuario`; Visualizar la tabla **usuarios**
    - mysql> SELECT * FROM `pedido`; Visualizar la tabla **Pedido**
    - mysql> SELECT * FROM `PedidoProducto` Visualizar la tabla **PedidoProducto**
    - mysql> WHERE  `pedido_id` = 1; Visualizar la tabla **pedido 1**

    - mysql> SELECT `pedido_id`, `producto_id`, `cantidad` FROM `PedidoProducto` Visualizar la tabla que usted elijas es con select y el nombre de la colomnas.




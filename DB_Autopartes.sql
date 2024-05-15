DROP DATABASE IF EXISTS `Autopartes`;
-- -----------------------------------------------------
-- Schema Autopartes
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `Autopartes`;
USE `Autopartes` ;


-- -----------------------------------------------------
-- Table `Autopartes`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Marca` (
  `marca_id` INT NOT NULL,
  `nombre_marca` VARCHAR(50) NULL,
  PRIMARY KEY (`marca_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Modelo` (
  `modelo_id` INT NOT NULL,
  `marca_id` INT NULL,
  `nombre_modelo` VARCHAR(50) NULL,
  `año_fabricacion` DATE NULL,
  PRIMARY KEY (`modelo_id`),
  CONSTRAINT `fk_marca_id`
    FOREIGN KEY (`marca_id`)
    REFERENCES `Autopartes`.`Marca` (`marca_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Fabricante` (
  `fabricante_id` INT NOT NULL,
  `nombre_fabricante` VARCHAR(50) NULL,
  PRIMARY KEY (`fabricante_id`));

-- -----------------------------------------------------
-- Table `Autopartes`.`Recambio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Recambio` (
  `recambio_id` INT NOT NULL,
  `categoria_id` VARCHAR(50) NULL,
  PRIMARY KEY (`recambio_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Autoparte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Autoparte` (
  `autoparte_id` INT NOT NULL,
  `modelo_id` INT NULL,
  `recambio_id` INT NULL,
  `fabricante_id` INT NULL,
  `tipo_id` INT NULL,
  `nombre_autoparte` VARCHAR(50) NULL,
  `precio_compra` FLOAT NULL,
  `precio_venta_max` FLOAT NULL,
  `precio_venta_min` FLOAT NULL,
  `unidades_stock` INT NULL,
  PRIMARY KEY (`autoparte_id`),
  CONSTRAINT `fk_modelo_id`
    FOREIGN KEY (`modelo_id`)
    REFERENCES `Autopartes`.`Modelo` (`modelo_id`),
  CONSTRAINT `fk_recambio_id`
    FOREIGN KEY (`recambio_id`)
    REFERENCES `Autopartes`.`Recambio` (`recambio_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Auto_Fabric (Comercio)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Auto_Fabric_Comercio` (
  `autoparte_id` INT NULL,
  `fabricante_id` INT NULL,
  CONSTRAINT `fk_autoparte_id`
    FOREIGN KEY (`autoparte_id`)
    REFERENCES `Autopartes`.`Autoparte` (`autoparte_id`),
  CONSTRAINT `fk_fabricante_id`
    FOREIGN KEY (`fabricante_id`)
    REFERENCES `Autopartes`.`Fabricante` (`fabricante_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Cliente` (
  `cliente_id` INT NOT NULL,
  `tipoCliente_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`, `tipoCliente_id`),
  INDEX `fk_tipoCliente_id_idx` (`tipoCliente_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Autopartes`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Venta` (
  `venta_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `IGV` FLOAT NULL,
  `nombre_vendedor` VARCHAR(50) NULL,
  `fecha_emision` DATE NULL,
  `fecha_cancelacion` DATE NULL,
  `num_guia` INT NULL,
  PRIMARY KEY (`venta_id`),
  CONSTRAINT `fk_cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Autopartes`.`Cliente` (`cliente_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`Detalle_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`Detalle_Venta` (
  `detalleVenta_id` INT NOT NULL,
  `venta_id` INT NOT NULL,
  `autoparte_id` INT NOT NULL,
  `cantidad_autoparte` INT NULL,
  `precio_unitario` FLOAT NULL,
  `importe` FLOAT NULL,
  `tipo_comprobante` CHAR(10) NULL,
  PRIMARY KEY (`detalleVenta_id`),
  CONSTRAINT `fk_autoparte_id_Detalle_Venta`
    FOREIGN KEY (`autoparte_id`)
    REFERENCES `Autopartes`.`Autoparte` (`autoparte_id`),
  CONSTRAINT `fk_venta_id`
    FOREIGN KEY (`venta_id`)
    REFERENCES `Autopartes`.`Venta` (`venta_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`PersonaNatural`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`PersonaNatural` (
  `pNatural_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `tipoCliente_id` INT NULL,
  `apellido` VARCHAR(50) NULL,
  `nombre` VARCHAR(50) NULL,
  `genero` VARCHAR(50) NULL,
  `tipo_doc` VARCHAR(50) NULL,
  `num_doc` VARCHAR(50) NULL,
  `fecha_nac` DATE NULL,
  `distrito` VARCHAR(50) NULL,
  `provincia` VARCHAR(50) NULL,
  `departamento` VARCHAR(50) NULL,
  `celular` VARCHAR(9) NULL,
  `fijo` VARCHAR(50) NULL,
  PRIMARY KEY (`pNatural_id`),
  CONSTRAINT `fk_cliente_id_PersonaNatural`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Autopartes`.`Cliente` (`cliente_id`),
  CONSTRAINT `fk_tipoCliente_id_PersonaNatural`
    FOREIGN KEY (`tipoCliente_id`)
    REFERENCES `Autopartes`.`Cliente` (`tipoCliente_id`));


-- -----------------------------------------------------
-- Table `Autopartes`.`PersonaJuridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autopartes`.`PersonaJuridica` (
  `pJuridica_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `tipoCliente_id` INT NULL,
  `razon_social` VARCHAR(50) NULL,
  `nr_RUC` VARCHAR(50) NULL,
  `direccion_fiscal` VARCHAR(50) NULL,
  `departamento` VARCHAR(50) NULL,
  `provincia` VARCHAR(50) NULL,
  `distrito` VARCHAR(50) NULL,
  `giro_empresa` VARCHAR(50) NULL,
  `representante_legal` VARCHAR(50) NULL,
  `pagina_web` VARCHAR(50) NULL,
  `email_compras` VARCHAR(50) NULL,
  `telefono` VARCHAR(9) NULL,
  `anexo` VARCHAR(50) NULL,
  `nr_celular` VARCHAR(9) NULL,
  PRIMARY KEY (`pJuridica_id`),
  CONSTRAINT `fk_cliente_id_PersonaJuridica`
    FOREIGN KEY (`tipoCliente_id`)
    REFERENCES `Autopartes`.`Cliente` (`cliente_id`),
  CONSTRAINT `fk_tipoCliente_id_PersonaJuridica`
    FOREIGN KEY (`tipoCliente_id`)
    REFERENCES `Autopartes`.`Cliente` (`tipoCliente_id`));

INSERT INTO `Autopartes`.`Marca` (`marca_id`, `nombre_marca`) VALUES
(1, 'Ford'),
(2, 'Toyota'),
(3, 'Chevrolet'),
(4, 'Nissan'),
(5, 'Volkswagen'),
(6, 'Mazda'),
(7, 'Honda'),
(8, 'BMW'),
(9, 'Mercedes-Benz'),
(10, 'Audi'),
(11, 'Jeep'),
(12, 'Dodge'),
(13, 'Ram'),
(14, 'Subaru'),
(15, 'Hyundai'),
(16, 'Kia'),
(17, 'Lexus'),
(18, 'Infiniti'),
(19, 'Mitsubishi'),
(20, 'Porsche'),
(21, 'Ferrari'),
(22, 'Lamborghini'),
(23, 'Acura'),
(24, 'Volvo'),
(25, 'Land Rover'),
(26, 'Jaguar'),
(27, 'Tesla'),
(28, 'Genesis'),
(29, 'Chrysler'),
(30, 'Buick'),
(31, 'GMC'),
(32, 'Cadillac'),
(33, 'Lincoln'),
(34, 'Suzuki'),
(35, 'Fiat'),
(36, 'Peugeot'),
(37, 'Renault'),
(38, 'Citroën'),
(39, 'Alfa Romeo'),
(40, 'Maserati');

INSERT INTO `Autopartes`.`Modelo` (`modelo_id`, `marca_id`, `nombre_modelo`, `año_fabricacion`) VALUES
(1, 1, 'Mustang', '1964-04-17'),
(2, 1, 'F-150', '1975-01-01'),
(3, 2, 'Corolla', '1966-11-05'),
(4, 2, 'Camry', '1982-03-10'),
(5, 3, 'Camaro', '1966-09-29'),
(6, 3, 'Silverado', '1998-01-01'),
(7, 4, 'Sentra', '1982-01-01'),
(8, 4, 'Altima', '1992-07-01'),
(9, 5, 'Jetta', '1979-01-01'),
(10, 5, 'Golf', '1974-05-01'),
(11, 1, 'Mustang GT', '1982-01-01'),
(12, 1, 'Explorer', '1991-01-01'),
(13, 2, 'Yaris', '1998-08-01'),
(14, 2, 'RAV4', '1994-01-01'),
(15, 3, 'Impala', '1958-01-01'),
(16, 3, 'Malibu', '1964-01-01'),
(17, 4, 'Versa', '2006-01-01'),
(18, 4, 'Maxima', '1988-01-01'),
(19, 5, 'Passat', '1973-01-01'),
(20, 5, 'Touareg', '2002-01-01'),
(21, 1, 'Bronco', '1966-01-01'),
(22, 1, 'Ranger', '1983-01-01'),
(23, 2, 'Supra', '1978-01-01'),
(24, 2, 'Tacoma', '1995-01-01'),
(25, 3, 'Trailblazer', '2002-01-01'),
(26, 3, 'Equinox', '2005-01-01'),
(27, 4, 'Cube', '1998-01-01'),
(28, 4, 'Murano', '2002-01-01'),
(29, 5, 'Beetle', '1938-01-01'),
(30, 5, 'Tiguan', '2007-01-01'),
(31, 1, 'Mustang Mach-E', '2020-01-01'),
(32, 1, 'Fusion', '2005-01-01'),
(33, 2, 'Avalon', '1994-01-01'),
(34, 2, 'Sienna', '1997-01-01'),
(35, 3, 'Traverse', '2009-01-01'),
(36, 3, 'Blazer', '1969-01-01'),
(37, 4, 'Pathfinder', '1986-01-01'),
(38, 4, 'Armada', '2003-01-01'),
(39, 5, 'Atlas', '2017-01-01'),
(40, 5, 'Golf R', '2002-01-01');

INSERT INTO `Autopartes`.`Fabricante` (`fabricante_id`, `nombre_fabricante`) VALUES
(1, 'Bosch'),
(2, 'Mann+Hummel'),
(3, 'Denso'),
(4, 'Valeo'),
(5, 'NGK'),
(6, 'Continental'),
(7, 'Hella'),
(8, 'Brembo'),
(9, 'TRW'),
(10, 'KYB'),
(11, 'Gates'),
(12, 'ACDelco'),
(13, 'Bilstein'),
(14, 'Delphi'),
(15, 'MagnaFlow'),
(16, 'K&N'),
(17, 'Goodyear'),
(18, 'Monroe'),
(19, 'BorgWarner'),
(20, 'Akebono'),
(21, 'Walker'),
(22, 'Wix Filters'),
(23, 'Beck/Arnley'),
(24, 'Moog'),
(25, 'Timken'),
(26, 'Fel-Pro'),
(27, 'Standard Motor Products'),
(28, 'GMB'),
(29, 'Four Seasons'),
(30, 'Stant'),
(31, 'Motorcraft'),
(32, 'ACI'),
(33, 'Cloyes'),
(34, 'Mevotech'),
(35, 'Spectra Premium'),
(36, 'Power Stop'),
(37, 'Rancho'),
(38, 'Skyjacker'),
(39, 'Eibach'),
(40, 'Koni');

INSERT INTO `Autopartes`.`Recambio` (`recambio_id`, `categoria_id`) VALUES
(1, 'Filtros'),
(2, 'Frenos'),
(3, 'Suspensión'),
(4, 'Transmisión'),
(5, 'Motor'),
(6, 'Sistema eléctrico'),
(7, 'Embrague'),
(8, 'Dirección'),
(9, 'Neumáticos'),
(10, 'Accesorios'),
(11, 'Bujías'),
(12, 'Correas'),
(13, 'Amortiguadores'),
(14, 'Discos de freno'),
(15, 'Pastillas de freno'),
(16, 'Kit de embrague'),
(17, 'Sensor de oxígeno'),
(18, 'Filtro de aire'),
(19, 'Filtro de aceite'),
(20, 'Filtro de combustible'),
(21, 'Llantas'),
(22, 'Baterías'),
(23, 'Bombas de agua'),
(24, 'Bombas de aceite'),
(25, 'Bombas de combustible'),
(26, 'Radiadores'),
(27, 'Termostatos'),
(28, 'Mangueras de radiador'),
(29, 'Terminales y juntas de dirección'),
(30, 'Barra estabilizadora'),
(31, 'Árbol de transmisión'),
(32, 'Junta homocinética'),
(33, 'Alternadores'),
(34, 'Motor de arranque'),
(35, 'Cables de bujías'),
(36, 'Sistemas de sonido'),
(37, 'Luces de neón'),
(38, 'Kit de carrocería'),
(39, 'Alerones'),
(40, 'Parachoques');

INSERT INTO `Autopartes`.`Autoparte` (`autoparte_id`, `modelo_id`, `recambio_id`, `fabricante_id`, `tipo_id`, `nombre_autoparte`, `precio_compra`, `precio_venta_max`, `precio_venta_min`, `unidades_stock`) VALUES
(1, 1, 1, 2, 1, 'Filtro de aceite', 10.0, 25.0, 20.0, 100),
(2, 2, 2, 1, 1, 'Pastillas de freno', 20.0, 50.0, 45.0, 50),
(3, 3, 3, 3, 2, 'Amortiguador trasero', 50.0, 120.0, 100.0, 20),
(4, 4, 2, 4, 1, 'Disco de freno', 30.0, 80.0, 70.0, 30),
(5, 1, 5, 5, 3, 'Bujía de encendido', 5.0, 15.0, 10.0, 200),
(6, 5, 4, 1, 1, 'Correa de distribución', 15.0, 40.0, 35.0, 60),
(7, 6, 1, 6, 1, 'Filtro de aire', 8.0, 20.0, 15.0, 80),
(8, 7, 6, 2, 3, 'Batería de coche', 70.0, 150.0, 130.0, 10),
(9, 8, 7, 7, 2, 'Embrague completo', 200.0, 500.0, 450.0, 5),
(10, 9, 8, 8, 1, 'Pinza de freno', 60.0, 150.0, 130.0, 15),
(11, 3, 9, 1, 2, 'Kit de suspensión', 200.0, 400.0, 350.0, 8),
(12, 5, 6, 3, 1, 'Tensor de correa', 25.0, 60.0, 50.0, 25),
(13, 2, 8, 5, 1, 'Cilindro maestro de freno', 60.0, 150.0, 130.0, 12),
(14, 1, 2, 7, 2, 'Caja de cambios', 500.0, 1000.0, 900.0, 3),
(15, 8, 1, 4, 3, 'Alternador', 80.0, 200.0, 180.0, 7),
(16, 6, 14, 6, 3, 'Batería de moto', 25.0, 60.0, 50.0, 15),
(17, 7, 15, 2, 2, 'Kit de embrague', 150.0, 350.0, 300.0, 7),
(18, 8, 16, 7, 1, 'Disco de embrague', 70.0, 150.0, 130.0, 20),
(19, 9, 1, 8, 1, 'Filtro de gasolina', 10.0, 25.0, 20.0, 60),
(20, 2, 17, 4, 2, 'Barra estabilizadora', 30.0, 80.0, 70.0, 25),
(21, 3, 18, 1, 3, 'Bujía de encendido de iridio', 15.0, 40.0, 35.0, 50),
(22, 4, 19, 3, 1, 'Pastillas de freno delanteras', 35.0, 80.0, 70.0, 40),
(23, 1, 20, 5, 2, 'Amortiguador delantero', 40.0, 100.0, 90.0, 20),
(24, 5, 5, 2, 1, 'Bujía de encendido de platino', 7.0, 20.0, 15.0, 150),
(25, 6, 3, 1, 1, 'Amortiguador de moto', 30.0, 70.0, 60.0, 10),
(26, 7, 2, 6, 3, 'Batería de camión', 100.0, 250.0, 220.0, 5),
(27, 8, 4, 7, 2, 'Volante motor', 150.0, 350.0, 300.0, 3),
(28, 6, 7, 8, 2, 'Amortiguador delantero', 45.0, 100.0, 80.0, 25),
(29, 5, 1, 5, 1, 'Filtro de combustible', 12.0, 30.0, 25.0, 60),
(30, 10, 8, 9, 1, 'Mordaza de freno', 50.0, 120.0, 100.0, 15),
(31, 9, 9, 1, 2, 'Suspensión completa', 350.0, 800.0, 700.0, 5),
(32, 2, 3, 3, 3, 'Bujía de encendido doble', 10.0, 25.0, 20.0, 150),
(33, 7, 2, 2, 1, 'Pastillas de freno traseras', 25.0, 60.0, 50.0, 30),
(34, 4, 4, 4, 3, 'Batería de moto', 30.0, 80.0, 70.0, 10),
(35, 1, 5, 5, 2, 'Bobina de encendido', 20.0, 50.0, 45.0, 50),
(36, 8, 6, 6, 1, 'Filtro de aire acondicionado', 10.0, 25.0, 20.0, 100),
(37, 5, 7, 8, 3, 'Alternador', 100.0, 250.0, 200.0, 10),
(38, 10, 9, 9, 2, 'Radiador', 70.0, 200.0, 180.0, 10),
(39, 11, 10, 7, 1, 'Bomba de agua', 40.0, 100.0, 90.0, 15),
(40, 12, 11, 5, 3, 'Alternador', 80.0, 200.0, 180.0, 7);

INSERT INTO `Autopartes`.`Auto_Fabric_Comercio` (`autoparte_id`, `fabricante_id`) VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(5, 1),
(6, 3),
(7, 1),
(8, 3),
(9, 2),
(10, 1),
(11, 4),
(12, 5),
(13, 6),
(14, 7),
(15, 8),
(16, 9),
(17, 10),
(18, 11),
(19, 12),
(20, 13),
(21, 14),
(22, 15),
(23, 16),
(24, 17),
(25, 18),
(26, 19),
(27, 20),
(28, 21),
(29, 22),
(30, 23),
(31, 24),
(32, 25),
(33, 26),
(34, 27),
(35, 28),
(36, 29),
(37, 30),
(38, 31),
(39, 32),
(40, 33);


INSERT INTO Autopartes.Cliente (cliente_id, tipoCliente_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 1),
(8, 2),
(9, 1),
(10, 2),
(11, 1),
(12, 2),
(13, 1),
(14, 2),
(15, 1),
(16, 2),
(17, 1),
(18, 2),
(19, 1),
(20, 2),
(21, 1),
(22, 2),
(23, 1),
(24, 2),
(25, 1),
(26, 2),
(27, 1),
(28, 2),
(29, 1),
(30, 2),
(31, 1),
(32, 2),
(33, 1),
(34, 2),
(35, 1),
(36, 2),
(37, 1),
(38, 2),
(39, 1),
(40, 2);

INSERT INTO `Autopartes`.`Venta` (`venta_id`, `cliente_id`, `IGV`, `nombre_vendedor`, `fecha_emision`, `fecha_cancelacion`, `num_guia`)
VALUES
(1, 1, 0.18, 'Juan Perez', '2023-05-01', '2023-05-05', 12345),
(2, 2, 0.18, 'Maria Gonzalez', '2023-05-02', NULL, NULL),
(3, 3, 0.18, 'Pedro Rodriguez', '2023-05-03', NULL, NULL),
(4, 1, 0.18, 'Juan Perez', '2023-05-04', NULL, NULL),
(5, 2, 0.18, 'Maria Gonzalez', '2023-05-05', '2023-05-06', 12346),
(6, 3, 0.18, 'Pedro Rodriguez', '2023-05-06', NULL, NULL),
(7, 1, 0.18, 'Juan Perez', '2023-05-07', '2023-05-09', 12347),
(8, 2, 0.18, 'Maria Gonzalez', '2023-05-08', NULL, NULL),
(9, 3, 0.18, 'Pedro Rodriguez', '2023-05-09', NULL, NULL),
(10, 1, 0.18, 'Juan Perez', '2023-05-10', NULL, NULL),
(11, 4, 0.18, 'Ana Hernandez', '2023-05-11', NULL, NULL),
(12, 5, 0.18, 'Carlos Gutierrez', '2023-05-12', '2023-05-13', 12348),
(13, 6, 0.18, 'Laura Ramirez', '2023-05-13', NULL, NULL),
(14, 7, 0.18, 'Pedro Morales', '2023-05-14', NULL, NULL),
(15, 8, 0.18, 'Juanita Perez', '2023-05-15', '2023-05-16', 12349),
(16, 9, 0.18, 'Roberto Rodriguez', '2023-05-16', NULL, NULL),
(17, 10, 0.18, 'Lucia Gonzalez', '2023-05-17', NULL, NULL),
(18, 11, 0.18, 'Mario Fernandez', '2023-05-18', NULL, NULL),
(19, 12, 0.18, 'Ana Perez', '2023-05-19', '2023-05-20', 12350),
(20, 13, 0.18, 'Luisa Martinez', '2023-05-20', NULL, NULL),
(21, 14, 0.18, 'Carlos Herrera', '2023-05-21', NULL, NULL),
(22, 15, 0.18, 'Pedro Mendoza', '2023-05-22', NULL, NULL),
(23, 16, 0.18, 'Sofia Diaz', '2023-05-23', '2023-05-25', 12351),
(24, 17, 0.18, 'Mario Suarez', '2023-05-24', NULL, NULL),
(25, 18, 0.18, 'Carmen Gomez', '2023-05-25', NULL, NULL),
(26, 19, 0.18, 'Fernando Torres', '2023-05-26', NULL, NULL),
(27, 20, 0.18, 'Ana Mora', '2023-05-27', '2023-05-28', 12352),
(28, 21, 0.18, 'Josefa Vega', '2023-05-28', NULL, NULL),
(29, 22, 0.18, 'Manuel Jimenez', '2023-05-29', NULL, NULL),
(30, 23, 0.18, 'Jorge Castro', '2023-05-30', NULL, NULL),
(31, 24, 0.18, 'Lorena Herrera', '2023-05-31', '2023-06-01', 12353),
(32, 25, 0.18, 'Raul Martinez', '2023-06-01', NULL, NULL),
(33, 26, 0.18, 'Mariana Gomez', '2023-06-02', NULL, NULL),
(34, 27, 0.18, 'Andres Hernandez', '2023-06-03', NULL, NULL),
(35, 28, 0.18, 'Andrea Ramirez', '2023-05-31', NULL, NULL),
(36, 29, 0.18, 'Jorge Garcia', '2023-06-01', '2023-06-05', 12351),
(37, 30, 0.18, 'Sofia Rodriguez', '2023-06-02', NULL, NULL),
(38, 31, 0.18, 'Manuel Torres', '2023-06-03', '2023-06-06', 12352),
(39, 32, 0.18, 'Laura Martinez', '2023-06-04', NULL, NULL),
(40, 33, 0.18, 'David Hernandez', '2023-06-05', '2023-06-08', 12353);

INSERT INTO `Autopartes`.`Detalle_Venta` (`detalleVenta_id`, `venta_id`, `autoparte_id`, `cantidad_autoparte`, `precio_unitario`, `importe`, `tipo_comprobante`)
VALUES
(1, 1, 1, 2, 50.0, 100.0, 'Boleta'),
(2, 1, 2, 1, 30.0, 30.0, 'Boleta'),
(3, 2, 3, 4, 20.0, 80.0, 'Factura'),
(4, 2, 4, 3, 35.0, 105.0, 'Factura'),
(5, 3, 5, 2, 25.0, 50.0, 'Boleta'),
(6, 3, 6, 1, 45.0, 45.0, 'Boleta'),
(7, 4, 7, 5, 15.0, 75.0, 'Factura'),
(8, 4, 8, 2, 40.0, 80.0, 'Factura'),
(9, 5, 9, 1, 55.0, 55.0, 'Boleta'),
(10, 5, 10, 3, 18.0, 54.0, 'Boleta'),
(11, 6, 11, 2, 50.0, 100.0, 'Boleta'),
(12, 6, 12, 1, 30.0, 30.0, 'Boleta'),
(13, 7, 13, 4, 20.0, 80.0, 'Factura'),
(14, 7, 14, 3, 35.0, 105.0, 'Factura'),
(15, 8, 15, 2, 25.0, 50.0, 'Boleta'),
(16, 8, 16, 1, 45.0, 45.0, 'Boleta'),
(17, 9, 17, 5, 15.0, 75.0, 'Factura'),
(18, 9, 18, 2, 40.0, 80.0, 'Factura'),
(19, 10, 19, 1, 55.0, 55.0, 'Boleta'),
(20, 10, 20, 3, 18.0, 54.0, 'Boleta'),
(21, 11, 21, 2, 50.0, 100.0, 'Boleta'),
(22, 11, 22, 1, 30.0, 30.0, 'Boleta'),
(23, 12, 23, 4, 20.0, 80.0, 'Factura'),
(24, 12, 24, 3, 35.0, 105.0, 'Factura'),
(25, 13, 25, 2, 25.0, 50.0, 'Boleta'),
(26, 13, 26, 1, 45.0, 45.0, 'Boleta'),
(27, 14, 27, 5, 15.0, 75.0, 'Factura'),
(28, 14, 28, 2, 40.0, 80.0, 'Factura'),
(29, 15, 29, 1, 55.0, 55.0, 'Boleta'),
(30, 15, 30, 3, 18.0, 54.0, 'Boleta'),
(31, 16, 31, 2, 50.0, 100.0, 'Boleta'),
(32, 16, 32, 1, 30.0, 30.0, 'Boleta'),
(33, 17, 33, 4, 20.0, 80.0, 'Factura'),
(34, 17, 34, 3, 35.0, 105.0, 'Factura'),
(35, 18, 35, 2, 25.0, 50.0, 'Boleta'),
(36, 18, 36, 1, 45.0, 45.0, 'Boleta'),
(37, 19, 37, 5, 15.0, 75.0, 'Factura'),
(38, 19, 38, 2, 25.0, 50.0, 'Boleta'),
(39, 20, 39, 3, 45.0, 45.0, 'Boleta'),
(40, 20, 40, 1, 15.0, 75.0, 'Factura');	

INSERT INTO `Autopartes`.`PersonaNatural` (`pNatural_id`, `cliente_id`, `tipoCliente_id`, `apellido`, `nombre`, `genero`, `tipo_doc`, `num_doc`, `fecha_nac`, `distrito`, `provincia`, `departamento`, `celular`, `fijo`) VALUES
(1, 1, 1, 'Gonzales', 'Maria', 'Femenino', 'DNI', '12345678', '1990-01-01', 'San Borja', 'Lima', 'Lima', '998877665', '017123456'),
(2, 2, 1, 'Hernandez', 'Juan', 'Masculino', 'DNI', '87654321', '1985-05-12', 'Miraflores', 'Lima', 'Lima', '986754321', '014567890'),
(3, 3, 1, 'Fernandez', 'Carlos', 'Masculino', 'DNI', '11111111', '1998-10-10', 'Surco', 'Lima', 'Lima', '954321876', '012345678'),
(4, 4, 1, 'Sanchez', 'Lucia', 'Femenino', 'DNI', '22222222', '1995-03-20', 'Barranco', 'Lima', 'Lima', '912345678', '017123456'),
(5, 5, 1, 'Torres', 'Pedro', 'Masculino', 'DNI', '33333333', '1992-07-22', 'Pueblo Libre', 'Lima', 'Lima', '987654321', '016789012'),
(6, 6, 1, 'Ruiz', 'Luz', 'Femenino', 'DNI', '44444444', '1999-12-31', 'San Isidro', 'Lima', 'Lima', '975318642', '014567890'),
(7, 7, 1, 'Jimenez', 'Miguel', 'Masculino', 'DNI', '55555555', '1991-02-14', 'San Miguel', 'Lima', 'Lima', '998877665', '017123456'),
(8, 8, 1, 'Garcia', 'Elena', 'Femenino', 'DNI', '66666666', '1988-06-03', 'Lince', 'Lima', 'Lima', '986754321', '014567890'),
(9, 9, 1, 'Diaz', 'Jorge', 'Masculino', 'DNI', '77777777', '1997-09-23', 'Jesús María', 'Lima', 'Lima', '987654321', '012345678'),
(10, 10, 1, 'Castillo', 'Ana', 'Femenino', 'DNI', '88888888', '1994-11-15', 'Chorrillos', 'Lima', 'Lima', '987654321', '016789012'),
(11, 11, 1, 'Lopez', 'Rosa', 'Femenino', 'DNI', '99999999', '1993-04-05', 'San Juan de Miraflores', 'Lima', 'Lima', '912345678', '017123456'),
(12, 12, 1, 'Gutierrez', 'Javier', 'Masculino', 'DNI', '10101010', '1989-09-09', 'Chaclacayo', 'Lima', 'Lima', '986754321', '014567890'),
(13, 13, 1, 'Cabrera', 'Martha', 'Femenino', 'DNI', '15121212', '1996-06-22', 'Breña', 'Lima', 'Lima', '975318642', '014567890'),
(14, 14, 1, 'Flores', 'Cesar', 'Masculino', 'DNI', '15131313', '1998-03-15', 'Magdalena del Mar', 'Lima', 'Lima', '998877665', '017123456'),
(15, 15, 1, 'Chavez', 'Luis', 'Masculino', 'DNI', '14151414', '1990-08-13', 'Los Olivos', 'Lima', 'Lima', '954321876', '012345678'),
(16, 16, 1, 'Rojas', 'Ana', 'Femenino', 'DNI', '15551515', '1993-12-29', 'La Molina', 'Lima', 'Lima', '912345678', '017123456'),
(17, 17, 1, 'Gonzalez', 'Diego', 'Masculino', 'DNI', '16561616', '1987-11-07', 'San Borja', 'Lima', 'Lima', '986754321', '014567890'),
(18, 18, 1, 'Vargas', 'Karen', 'Femenino', 'DNI', '17571717', '1995-02-08', 'San Isidro', 'Lima', 'Lima', '987654321', '012345678'),
(19, 19, 1, 'Sandoval', 'Ricardo', 'Masculino', 'DNI', '18181518', '1999-09-18', 'San Miguel', 'Lima', 'Lima', '987654321', '016789012'),
(20, 20, 1, 'Suarez', 'Karina', 'Femenino', 'DNI', '15191916', '1991-07-01', 'Miraflores', 'Lima', 'Lima', '975318642', '014567890'),
(21, 21, 1, 'Salazar', 'José', 'Masculino', 'DNI', '25202050', '1994-05-20', 'La Victoria', 'Lima', 'Lima', '998877665', '017123456'),
(22, 22, 1, 'Vega', 'Margarita', 'Femenino', 'DNI', '25212121', '1997-10-17', 'San Juan de Lurigancho', 'Lima', 'Lima', '912345678', '017123456'),
(23, 23, 1, 'Perez', 'Carlos', 'Masculino', 'DNI', '15181818', '1990-06-15', 'San Borja', 'Lima', 'Lima', '998877665', '017123456'),
(24, 24, 1, 'Mendoza', 'Silvia', 'Femenino', 'DNI', '15191619', '1988-03-12', 'Miraflores', 'Lima', 'Lima', '986754321', '014567890'),
(25, 25, 1, 'Santos', 'Gabriela', 'Femenino', 'DNI', '21202020', '1992-10-17', 'Surco', 'Lima', 'Lima', '954321876', '012345678'),
(26, 26, 1, 'Gutierrez', 'Mauricio', 'Masculino', 'DNI', '26212161', '1989-05-22', 'Barranco', 'Lima', 'Lima', '912345678', '017123456'),
(27, 27, 1, 'Flores', 'Monica', 'Femenino', 'DNI', '25232323', '1997-11-24', 'San Isidro', 'Lima', 'Lima', '975318642', '014567890'),
(28, 28, 1, 'Rodriguez', 'Esteban', 'Masculino', 'DNI', '25242424', '1994-02-11', 'San Miguel', 'Lima', 'Lima', '998877665', '017123456'),
(29, 29, 1, 'Chavez', 'Carla', 'Femenino', 'DNI', '26252525', '1993-09-05', 'Lince', 'Lima', 'Lima', '986754321', '014567890'),
(30, 30, 1, 'Diaz', 'Mauricio', 'Masculino', 'DNI', '26262626', '1996-12-19', 'Jesús María', 'Lima', 'Lima', '987654321', '012345678'),
(31, 31, 1, 'Garcia', 'Paola', 'Femenino', 'DNI', '27272727', '1991-07-07', 'Chorrillos', 'Lima', 'Lima', '987654321', '016789012'),
(32, 32, 1, 'Rojas', 'Luis', 'Masculino', 'DNI', '28282828', '1988-08-08', 'San Juan de Miraflores', 'Lima', 'Lima', '912345678', '017123456'),
(33, 33, 1, 'Santos', 'Isabel', 'Femenino', 'DNI', '29292929', '1995-03-18', 'Chaclacayo', 'Lima', 'Lima', '986754321', '014567890'),
(34, 34, 1, 'Reyes', 'Mariana', 'Femenino', 'DNI', '11181818', '1992-09-16', 'San Juan de Lurigancho', 'Lima', 'Lima', '987654321', '012345678'),
(35, 35, 1, 'Luna', 'Manuel', 'Masculino', 'DNI', '11191919', '1998-04-20', 'Lurin', 'Lima', 'Lima', '975318642', '014567890'),
(36, 36, 1, 'Palacios', 'Luisa', 'Femenino', 'DNI', '29202020', '1991-07-10', 'San Isidro', 'Lima', 'Lima', '998877665', '017123456'),
(37, 37, 1, 'Figueroa', 'Javier', 'Masculino', 'DNI', '29212121', '1993-11-25', 'Barranco', 'Lima', 'Lima', '986754321', '014567890'),
(38, 38, 1, 'Carrillo', 'Sofia', 'Femenino', 'DNI', '29232323', '1997-02-03', 'Miraflores', 'Lima', 'Lima', '987654321', '012345678'),
(39, 39, 1, 'Cordova', 'Luis', 'Masculino', 'DNI', '29242424', '1990-12-12', 'Surco', 'Lima', 'Lima', '912345678', '017123456'),
(40, 40, 1, 'Aguilar', 'Carmen', 'Femenino', 'DNI', '29252525', '1995-05-05', 'Chorrillos', 'Lima', 'Lima', '954321876', '012345678');



INSERT INTO `Autopartes`.`PersonaJuridica`
(`pJuridica_id`, `cliente_id`, `tipoCliente_id`, `razon_social`, `nr_RUC`, `direccion_fiscal`, `departamento`, `provincia`, `distrito`, `giro_empresa`, `representante_legal`, `pagina_web`, `email_compras`, `telefono`, `anexo`, `nr_celular`)
VALUES
(1, 1, 2, 'Empresa A', '12345678901', 'Av. Los Olivos 123', 'Lima', 'Lima', 'Los Olivos', 'Comercio al por mayor', 'Juan Pérez', 'www.empresaA.com', 'compras@empresaA.com', '1234567', '123', '987654321'),
(2, 2, 2, 'Empresa B', '23456789012', 'Av. Los Claveles 456', 'Lima', 'Lima', 'Lince', 'Comercio al por menor', 'Ana García', 'www.empresaB.com', 'compras@empresaB.com', '2345678', '456', '987624321'),
(3, 3, 2, 'Empresa C', '34567890123', 'Av. Los Girasoles 789', 'Lima', 'Lima', 'San Borja', 'Servicios', 'Carlos Gómez', 'www.empresaC.com', 'compras@empresaC.com', '3456789', '789', '987653321'),
(4, 4, 2, 'Empresa D', '45678901234', 'Av. Las Palmeras 12', 'Lima', 'Lima', 'San Miguel', 'Comercio al por mayor', 'María Rodríguez', 'www.empresaD.com', 'compras@empresaD.com', '4567890', '12', '984654321'),
(5, 5, 2, 'Empresa E', '56789012345', 'Av. Las Orquídeas 345', 'Lima', 'Lima', 'Miraflores', 'Comercio al por menor', 'Luisa Torres', 'www.empresaE.com', 'compras@empresaE.com', '5678901', '345', '985654321'),
(6, 6, 2, 'Empresa F', '67890123456', 'Av. Los Tulipanes 678', 'Lima', 'Lima', 'San Isidro', 'Servicios', 'Pedro Sánchez', 'www.empresaF.com', 'compras@empresaF.com', '6789012', '678', '987657321'),
(7, 7, 2, 'Empresa G', '78901234567', 'Av. Las Azaleas 901', 'Lima', 'Lima', 'Surco', 'Comercio al por mayor', 'Laura Torres', 'www.empresaG.com', 'compras@empresaG.com', '7890123', '901', '987874321'),
(8, 8, 2, 'Empresa H', '89012345678', 'Av. Los Jazmines 234', 'Lima', 'Lima', 'Barranco', 'Servicios', 'Jorge Ramírez', 'www.empresaH.com', 'compras@empresaH.com', '8901234', '234', '987621421'),
(9, 9, 2, 'Empresa I', '90123456789', 'Av. Los Pinos 567', 'Lima', 'Lima', 'Chorrillos', 'Comercio al por menor', 'Paola Cruz', 'www.empresaI.com', 'compras@empresaI.com', '9012345', '567', '987434321'),
(10, 10, 2, 'Empresa J', '01234567890', 'Av. Los Cipreses 890', 'Lima', 'Lima', 'La Molina', 'Comercio al por mayor', 'Miguel Álvarez', 'www.empresaJ.com', 'compras@empresaJ.com', '0123456', '890', '981654321'),
(11, 11, 2, 'Empresa K', '98765432109', 'Av. Las Acacias 123', 'Lima', 'Lima', 'Surquillo', 'Servicios', 'Lucía Flores', 'www.empresaK.com', 'compras@empresaK.com', '9876543', '123', '983424321'),
(12, 12, 2, 'Empresa L', '87654321098', 'Av. Los Pájaros 456', 'Lima', 'Lima', 'Lurín', 'Comercio al por menor', 'Carlos García', 'www.empresaL.com', 'compras@empresaL.com', '8765432', '456', '954354321'),
(13, 13, 2, 'Empresa M', '76543210987', 'Av. Las Golondrinas 789', 'Lima', 'Lima', 'Chorrillos', 'Comercio al por mayor', 'Sandra López', 'www.empresaM.com', 'compras@empresaM.com', '7654321', '789', '985444321'),
(14, 14, 2, 'Empresa N', '65432109876', 'Av. Las Rosas 12', 'Lima', 'Lima', 'San Borja', 'Servicios', 'Roberto Torres', 'www.empresaN.com', 'compras@empresaN.com', '6543210', '12', '987654321'),
(15, 15, 2, 'Empresa O', '54321098765', 'Av. Las Margaritas 345', 'Lima', 'Lima', 'Miraflores', 'Comercio al por menor', 'Martha Suárez', 'www.empresaO.com', 'compras@empresaO.com', '5432109', '345', '985554321'),
(16, 16, 2, 'Empresa P', '43210987654', 'Av. Los Girasoles 678', 'Lima', 'Lima', 'San Isidro', 'Servicios', 'Javier Flores', 'www.empresaP.com', 'compras@empresaP.com', '4321098', '678', '987444321'),
(17, 17, 2, 'Empresa Q', '32109876543', 'Av. Las Azaleas 901', 'Lima', 'Lima', 'Barranco', 'Comercio al por mayor', 'Silvia Pérez', 'www.empresaQ.com', 'compras@empresaQ.com', '3210987', '901', '987324321'),
(18, 18, 2, 'Empresa R', '23456789011', 'Av. Los Girasoles 112', 'Lima', 'Lima', 'San Borja', 'Comercio al por mayor', 'Ana Torres', 'www.empresaR.com', 'compras@empresaR.com', '2345678', '112', '987614321'),
(19, 19, 2, 'Empresa S', '34567890122', 'Av. Las Palmeras 221', 'Lima', 'Lima', 'San Miguel', 'Comercio al por menor', 'Mario Gómez', 'www.empresaS.com', 'compras@empresaS.com', '3456789', '221', '987671321'),
(20, 20, 2, 'Empresa T', '45678901233', 'Av. Los Claveles 332', 'Lima', 'Lima', 'Lince', 'Comercio al por mayor', 'Lucía Pérez', 'www.empresaT.com', 'compras@empresaT.com', '4567890', '332', '987657121'),
(21, 21, 2, 'Empresa U', '56789012344', 'Av. Las Orquídeas 443', 'Lima', 'Lima', 'Miraflores', 'Servicios', 'Diego Torres', 'www.empresaU.com', 'compras@empresaU.com', '5678901', '443', '987654331'),
(22, 22, 2, 'Empresa V', '67890123455', 'Av. Los Tulipanes 554', 'Lima', 'Lima', 'San Isidro', 'Comercio al por menor', 'Fernanda Sánchez', 'www.empresaV.com', 'compras@empresaV.com', '6789012', '554', '944154321'),
(23, 23, 2, 'Empresa W', '78901234566', 'Av. Las Azaleas 665', 'Lima', 'Lima', 'Surco', 'Comercio al por mayor', 'Santiago Ramírez', 'www.empresaW.com', 'compras@empresaW.com', '7890123', '665', '987644321'),
(24, 24, 2, 'Empresa X', '89012345677', 'Av. Los Jazmines 776', 'Lima', 'Lima', 'Barranco', 'Servicios', 'Valentina Torres', 'www.empresaX.com', 'compras@empresaX.com', '8901234', '776', '987654331'),
(25, 25, 2, 'Empresa Y', '90123456788', 'Av. Las Orquídeas 887', 'Lima', 'Lima', 'Miraflores', 'Comercio al por mayor', 'Emilio Gómez', 'www.empresaY.com', 'compras@empresaY.com', '9012345', '887', '987654322'),
(26, 26, 2, 'Empresa Z', '78901234561', 'Av. Los Cactus 789', 'Lima', 'Lima', 'Lurigancho', 'Comercio al por menor', 'Mauricio Rojas', 'www.empresaP.com', 'compras@empresaP.com', '5678901', '789', '987654321'),
(27, 27, 2, 'Empresa AA', '89012345672', 'Av. Los Ficus 123', 'Lima', 'Lima', 'Santiago de Surco', 'Servicios', 'Daniela Aguilar', 'www.empresaQ.com', 'compras@empresaQ.com', '6789012', '123', '983456321'),
(28, 28, 2, 'Empresa BB', '90123456783', 'Av. Las Palmas 456', 'Lima', 'Lima', 'San Juan de Miraflores', 'Comercio al por mayor', 'Cristina Pérez', 'www.empresaR.com', 'compras@empresaR.com', '4567890', '456', '981254321'),
(29, 29, 2, 'Empresa CC', '01234567894', 'Av. Los Pinos 567', 'Lima', 'Lima', 'Surquillo', 'Comercio al por menor', 'Lorenzo Gómez', 'www.empresaS.com', 'compras@empresaS.com', '9012345', '567', '986544321'),
(30, 30, 2, 'Empresa DD', '98765432105', 'Av. Las Azucenas 890', 'Lima', 'Lima', 'San Miguel', 'Servicios', 'Natalia Ramírez', 'www.empresaT.com', 'compras@empresaT.com', '0123456', '890', '981254321'),
(31, 31, 2, 'Empresa EE', '87654321096', 'Av. Los Nogales 123', 'Lima', 'Lima', 'San Borja', 'Comercio al por mayor', 'Fernando Castro', 'www.empresaU.com', 'compras@empresaU.com', '9876543', '123', '983154321'),
(32, 32, 2, 'Empresa FF', '76543210987', 'Av. Las Margaritas 456', 'Lima', 'Lima', 'Lince', 'Comercio al por menor', 'Marisol Torres', 'www.empresaV.com', 'compras@empresaV.com', '8765432', '456', '985654321'),
(33, 33, 2, 'Empresa GG', '65432109876', 'Av. Los Pájaros 789', 'Lima', 'Lima', 'Barranco', 'Servicios', 'Diego Fernández', 'www.empresaW.com', 'compras@empresaW.com', '7654321', '789', '987433123'),
(34, 34, 2, 'Empresa HH', '65432109876', 'Av. Los Cactus 1011', 'Lima', 'Lima', 'Surco', 'Comercio al por mayor', 'Gabriel Mendoza', 'www.empresaO.com', 'compras@empresaO.com', '1011121', '111', '985432143'),
(35, 35, 2, 'Empresa II', '54321098765', 'Av. Los Naranjos 1314', 'Lima', 'Lima', 'San Isidro', 'Comercio al por menor', 'Luciana Torres', 'www.empresaP.com', 'compras@empresaP.com', '1314151', '151', '985654341'),
(36, 36, 2, 'Empresa JJ', '43210987654', 'Av. Las Azucenas 1617', 'Lima', 'Lima', 'Surquillo', 'Servicios', 'Manuel Pérez', 'www.empresaQ.com', 'compras@empresaQ.com', '1617181', '181', '985667221'),
(37, 37, 2, 'Empresa KK', '32109876543', 'Av. Los Rosales 1920', 'Lima', 'Lima', 'San Borja', 'Comercio al por mayor', 'Ana María Sánchez', 'www.empresaR.com', 'compras@empresaR.com', '1920211', '211', '986784321'),
(38, 38, 2, 'Empresa LL', '21098765432', 'Av. Los Almendros 2223', 'Lima', 'Lima', 'La Molina', 'Comercio al por menor', 'Diego González', 'www.empresaS.com', 'compras@empresaS.com', '2223241', '241', '987654321'),
(39, 39, 2, 'Empresa MM', '10987654321', 'Av. Los Jardines 2526', 'Lima', 'Lima', 'San Isidro', 'Servicios', 'Marta Pérez', 'www.empresaT.com', 'compras@empresaT.com', '2526271', '271', '987553321'),
(40, 40, 2, 'Empresa NN', '09876543210', 'Av. Las Margaritas 2829', 'Lima', 'Lima', 'Miraflores', 'Comercio al por mayor', 'Juan García', 'www.empresaU.com', 'compras@empresaU.com', '2829301', '301', '986547321');


-- -----------------------------------------------------
-- Ejercicio 1.
-- -----------------------------------------------------
DROP USER IF EXISTS user01;
flush privileges;
create user user01 
identified by 'user01';
grant all privileges on Autopartes.* to user01;


DROP USER IF EXISTS user02;
flush privileges;
create user user02
identified by 'user02';
grant all privileges on Autopartes.cliente to user02;   
grant all privileges on Autopartes.autoparte to user02;

-- -----------------------------------------------------
-- Ejercicio 2.
-- -----------------------------------------------------
revoke insert, update on Autopartes.cliente from user02;
revoke insert, update on Autopartes.autoparte from user02;


-- -----------------------------------------------------
-- Ejercicio 3.
-- -----------------------------------------------------
ALTER TABLE autoparte ADD CHECK (unidades_stock >= 0); -- autoparte es el nombre de mi tabla Productos

ALTER TABLE personanatural ADD UNIQUE (num_doc); -- personanatural es el nombre de mi tabla cliente natural


-- -----------------------------------------------------
-- Ejercicio 4.
-- -----------------------------------------------------
ALTER TABLE autoparte ADD COLUMN precioOferta FLOAT; -- default 0.1*precio_venta_min;


-- -----------------------------------------------------
-- Ejercicio 5.
-- -----------------------------------------------------
SELECT 
    `precio_unitario`
FROM 
    `detalle_venta`
WHERE 
    `venta_id` IN (SELECT 
                        `venta_id`
                    FROM 
                        `venta`
                    WHERE 
                        `cliente_id`> 20);


-- -----------------------------------------------------
-- Ejercicio 6.
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Autopartes`.`Venta` (`venta_id`, `cliente_id`, `IGV`, `nombre_vendedor`, `fecha_emision`, `fecha_cancelacion`, `num_guia`)
VALUES (41, 33, 0.18, 'David Hernandez', '2023-06-05', '2023-06-08', 12353);

insert into autopartes.detalle_venta (detalleVenta_id,venta_id, autoparte_id, cantidad_autoparte, precio_unitario, importe, tipo_comprobante)
values (41, 1, 1, 43, 5.0, 100.0, 'Boleta');

select * from detalle_venta join venta on detalle_venta.venta_id = venta.venta_id;

ROLLBACK;
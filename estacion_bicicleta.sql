-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-10-2026 a las 18:21:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `estacion_bicicleta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bicicleta`
--

CREATE TABLE `bicicleta` (
  `nro_serie` varchar(25) NOT NULL,
  `estado_b` enum('EN MANTENIMIENTO','EN USO','DISPONIBLE') DEFAULT 'DISPONIBLE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estacion`
--

CREATE TABLE `estacion` (
  `id_est` int(11) NOT NULL,
  `id_bicicleta` varchar(25) DEFAULT NULL,
  `cap_max` int(11) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento`
--

CREATE TABLE `mantenimiento` (
  `id_mant` int(11) NOT NULL,
  `empleado` int(11) NOT NULL,
  `estacion` int(11) NOT NULL,
  `descripcion` varchar(125) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medio_de_pago`
--

CREATE TABLE `medio_de_pago` (
  `id_pago` int(11) NOT NULL,
  `medio_de_pago` enum('tarjeta','QR') DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fecha_hora_pago` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operario`
--

CREATE TABLE `operario` (
  `legajo` int(11) NOT NULL,
  `nombre_op` varchar(25) DEFAULT NULL,
  `apellido_op` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `DNI` int(11) NOT NULL,
  `nombre_us` varchar(25) DEFAULT NULL,
  `apellido_us` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `id_viaje` int(11) NOT NULL,
  `estacion_origen` int(11) NOT NULL,
  `estacion_destino` int(11) NOT NULL,
  `usuario_cont` int(11) NOT NULL,
  `fecha_hora_ini` date DEFAULT current_timestamp(),
  `fecha_hora_fin` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bicicleta`
--
ALTER TABLE `bicicleta`
  ADD PRIMARY KEY (`nro_serie`);

--
-- Indices de la tabla `estacion`
--
ALTER TABLE `estacion`
  ADD PRIMARY KEY (`id_est`),
  ADD KEY `fk_id_bicicletas` (`id_bicicleta`);

--
-- Indices de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD PRIMARY KEY (`id_mant`,`estacion`),
  ADD KEY `fk_empleado` (`empleado`),
  ADD KEY `fk_estacion` (`estacion`);

--
-- Indices de la tabla `medio_de_pago`
--
ALTER TABLE `medio_de_pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_us` (`usuario`);

--
-- Indices de la tabla `operario`
--
ALTER TABLE `operario`
  ADD PRIMARY KEY (`legajo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`DNI`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`id_viaje`),
  ADD KEY `fk_dni` (`usuario_cont`),
  ADD KEY `fk_origen` (`estacion_origen`),
  ADD KEY `fk_destino` (`estacion_destino`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estacion`
--
ALTER TABLE `estacion`
  MODIFY `id_est` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  MODIFY `id_mant` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medio_de_pago`
--
ALTER TABLE `medio_de_pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `viaje`
--
ALTER TABLE `viaje`
  MODIFY `id_viaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estacion`
--
ALTER TABLE `estacion`
  ADD CONSTRAINT `fk_id_bicicletas` FOREIGN KEY (`id_bicicleta`) REFERENCES `bicicleta` (`nro_serie`);

--
-- Filtros para la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD CONSTRAINT `fk_empleado` FOREIGN KEY (`empleado`) REFERENCES `operario` (`legajo`),
  ADD CONSTRAINT `fk_estacion` FOREIGN KEY (`estacion`) REFERENCES `estacion` (`id_est`);

--
-- Filtros para la tabla `medio_de_pago`
--
ALTER TABLE `medio_de_pago`
  ADD CONSTRAINT `fk_us` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`DNI`) ON DELETE CASCADE;

--
-- Filtros para la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `fk_destino` FOREIGN KEY (`estacion_destino`) REFERENCES `estacion` (`id_est`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dni` FOREIGN KEY (`usuario_cont`) REFERENCES `usuario` (`DNI`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_origen` FOREIGN KEY (`estacion_origen`) REFERENCES `estacion` (`id_est`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

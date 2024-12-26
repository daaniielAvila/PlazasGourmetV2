-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-12-2024 a las 00:24:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `plazasgourmetv2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `id_restaurante` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `fecha_reserva` date NOT NULL,
  `hora_reserva` time NOT NULL,
  `numero_personas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `id_restaurante`, `nombre`, `telefono`, `fecha_reserva`, `hora_reserva`, `numero_personas`) VALUES
(11, 3, 'd', '7657657', '2024-12-27', '06:59:00', 3),
(12, 3, 'd', '777777', '2024-12-27', '07:59:00', 2),
(16, 4, 'd', '5656', '2024-12-29', '15:30:00', 3),
(17, 9, 'd', '6565', '2024-12-22', '05:46:00', 2),
(18, 7, 'Daniel', '654011866', '2024-12-29', '21:50:00', 2),
(19, 3, 'Marcos', '666666666', '2024-12-27', '16:15:00', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurantes`
--

CREATE TABLE `restaurantes` (
  `id` int(11) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo_comida` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `mesas_totales` int(11) NOT NULL,
  `mesas_disponibles` int(11) NOT NULL,
  `imagenes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `restaurantes`
--

INSERT INTO `restaurantes` (`id`, `correo`, `contraseña`, `nombre`, `tipo_comida`, `ubicacion`, `mesas_totales`, `mesas_disponibles`, `imagenes`) VALUES
(1, 'gourmet@example.com', 'password123', 'Restaurante Gourmet', 'Italiana', 'Madrid, España', 20, 15, 'imagenes/restaurante1.jpg'),
(3, 'asiafusion@example.com', 'fusion2024', 'Asia Fusión', 'italiana', 'Valencia, España', 30, 23, 'imagenes/restaurante3.jpg'),
(4, 'vegano@example.com', 'veg2024pass', 'Green Vegano', 'Vegana', 'Sevilla, España', 18, 10, 'imagenes/restaurante4.jpg'),
(5, 'mariscos@example.com', 'mariscos456', 'Sabores del Mar', 'Mariscos', 'Málaga, España', 12, 8, 'imagenes/restaurante5.jpg'),
(6, 'qjqkd90@gmail.com', '123', '123', 'italiana', '123', 123, 12, NULL),
(7, 'abc@gmail.com', 'abc', 'abc', 'italiana', 'abc', 15, 11, NULL),
(8, 'asiannnnfood1@gmail.com', 'asiannfood123', 'AsianFood', 'japonesa', 'Valencia, España', 20, 10, NULL),
(9, 'Italyy82562@gmail.com', 'italy725346', 'Casa Paco', 'mexicana', 'Valencia, España', 33, 12, NULL),
(10, 'ejemplo1@gmail.com', 'ejemplo', 'ejemplo2', 'mexicana', 'ejemplo', 10, 5, NULL),
(11, 'asiafusigfon@example.com', 'a', 'a', 'mexicana', 'Barcelona, España', 2, 1, NULL),
(12, 'me4353xicana@example.com', '123', '123342', 'japonesa', '443', 123, 12, NULL),
(13, '43534qjqkd90@gmail.com', '123', '123333', 'italiana', 'Valencia, España', 123, 10, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_restaurante` (`id_restaurante`);

--
-- Indices de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurantes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

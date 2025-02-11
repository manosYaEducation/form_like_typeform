-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 11-02-2025 a las 22:33:20
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
-- Base de datos: `forms`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `user_rut` varchar(20) NOT NULL,
  `question_id` int(11) NOT NULL,
  `selected_option` char(1) NOT NULL,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `answers`
--

INSERT INTO `answers` (`id`, `user_rut`, `question_id`, `selected_option`, `answered_at`) VALUES
(1, '2114541329', 1, 'A', '2025-02-11 20:49:11'),
(2, '2114541329', 1, 'A', '2025-02-11 20:49:57'),
(3, '2114541329', 2, 'D', '2025-02-11 20:49:57'),
(4, '128312', 1, 'A', '2025-02-11 20:53:07'),
(5, '128312', 2, 'B', '2025-02-11 20:53:07'),
(6, '123', 1, 'B', '2025-02-11 20:55:55'),
(7, '123', 2, 'C', '2025-02-11 20:55:55'),
(8, '123', 3, 'A', '2025-02-11 20:55:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`) VALUES
(1, '¿Ha integrado en su política de empresa un plan o estrategia de transición a la economía circular?\r\n¿Su estrategia está alineada con volverse más circular?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado al menos 1 iniciativa', 'No se ha considerado'),
(2, '¿Analiza o gestiona los riesgos y las oportunidades de negocio asociadas a la economía circular? ¿Analiza los riesgos de permanecer en una economía lineal?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado', 'No se ha considerado'),
(3, '¿Tiene objetivos de economía circular medibles?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `rut` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rut`, `nombre`, `correo`, `created_at`) VALUES
(1, '21.145.502-0', 'Mauricio', 'Mauricioguerrero14@gmail.com', '2025-02-11 20:21:00'),
(2, '22.123.323-4', 'Jose', 'jose@gmail.com', '2025-02-11 20:44:41'),
(3, '2114541329', 'mauricio', 'huerrer@kfaks.com', '2025-02-11 20:49:07'),
(5, '128312', 'miguel', 'huerrser@kfaks.com', '2025-02-11 20:53:05'),
(6, '123', 'jorge', 'huerrsr@kfaks.com', '2025-02-11 20:55:51');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indices de la tabla `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rut` (`rut`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

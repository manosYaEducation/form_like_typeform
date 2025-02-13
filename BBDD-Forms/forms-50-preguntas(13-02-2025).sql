-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 13-02-2025 a las 22:54:32
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

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

DROP TABLE IF EXISTS `answers`;
CREATE TABLE IF NOT EXISTS `answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_rut` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `question_id` int NOT NULL,
  `selected_option` char(1) COLLATE utf8mb4_general_ci NOT NULL,
  `answered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(8, '123', 3, 'A', '2025-02-11 20:55:55'),
(9, '123213', 1, 'B', '2025-02-12 20:52:40'),
(10, '123213', 2, 'D', '2025-02-12 20:52:40'),
(11, '123213', 3, 'A', '2025-02-12 20:52:40'),
(12, '123213', 4, 'C', '2025-02-12 20:52:44'),
(13, '123213', 5, 'D', '2025-02-12 20:52:44'),
(14, '123213', 6, 'A', '2025-02-12 20:52:44'),
(15, '21.145.502-0', 1, 'A', '2025-02-12 20:56:02'),
(16, '21.145.502-0', 2, 'A', '2025-02-12 20:56:02'),
(17, '21.145.502-0', 3, 'B', '2025-02-12 20:56:02'),
(18, '21.145.502-0', 1, 'A', '2025-02-12 21:15:16'),
(19, '21.145.502-0', 2, 'A', '2025-02-12 21:15:16'),
(20, '21.145.502-0', 3, 'B', '2025-02-12 21:15:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_text` text COLLATE utf8mb4_general_ci NOT NULL,
  `option_a` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `option_b` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `option_c` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `option_d` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`) VALUES
(1, '¿Ha integrado en su política de empresa un plan o estrategia de transición a la economía circular?\r\n¿Su estrategia está alineada con volverse más circular?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado al menos 1 iniciativa', 'No se ha considerado'),
(2, '¿Analiza o gestiona los riesgos y las oportunidades de negocio asociadas a la economía circular? ¿Analiza los riesgos de permanecer en una economía lineal?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado', 'No se ha considerado'),
(3, '¿Tiene objetivos de economía circular medibles?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado'),
(4, '¿Dispone de un presupuesto para sus iniciativas de economía circular?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado'),
(5, '¿Cuenta con alguna ayuda financiera o subsidio de apoyo a la economía circular/eficiencia energética?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado'),
(6, '¿Ha lanzado alguna campaña de sensibilización sobre la economía circular (comunicaciones a nivel interno o externo)?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado'),
(7, '¿Incorpora actividades de formación en economía circular entre sus colaboradores/trabajadores?', 'Plan integrado y en operación', 'En desarrollo plan y aplicación', 'Se ha coniderado al menos 1 iniciativa', 'No se ha considerado'),
(8, '¿Ha implementado un sistema de gestión ambiental  de \"cero residuos\", o utiliza alguna herramienta para alcanzar ese objetivo?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase  experimental', 'No se ha considerado ( o no aplica)'),
(9, '¿Utiliza alguna herramienta para evaluar el impacto ambiental de sus productos/servicios (Por ejemplo, Análisis de Ciclo de Vida, ACV)?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado está en fase experimental', 'No se ha considerado (o no aplica)'),
(10, '¿Contempla aspectos ambientales o ecológicos en el diseño de sus productos/servicios?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase experimental', 'No se ha considerado (o no aplica)'),
(11, '¿Utiliza algún tipo de \"ecoetiquetado\" (ela hídrica, ...) en sus productos o servicios?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase experimental', 'No se ha considerado (o no aplica)'),
(12, '¿Mantiene un espacio de trabajo de (coworking, teletrabajo, servicios en la nube, etc.)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(13, '¿Ha implantado la industria o servicios 4.0 para optimizar el uso/suministro de materias primas/energía o prevenir la generación de residuos?(por ejemplo, automatización, uso de sensores, etc.)', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(14, '¿En que medida su empresa esta implementando sistemas digitales para apoyar productos o servicios circulares?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(15, '¿En qué medida su empresa está implementando sistemas digitales para optimizar los procesos de operación de la empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(16, '¿Ha digitalizado documentos tales como precedimientos de trabajo, reportes o manuales de instrucciones de producto, sustituyendo los formatos en papel?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(17, '¿Prioriza el uso de campañas publicitarias o comunicaciones digitales, sustituyendo a la publicidad o correspondencia en soporte físico?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado'),
(18, '¿Considera el mantenimiento/reparación/venta de piezas de repuesto de sus productos como parte de las lineas de negocio de su empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado'),
(19, '¿Incluye la venta de productos de segunda mano como una linea de negocio en su empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado'),
(20, '¿Promueve o participa en iniciativas para la recogida parcial o total de los productos que fabrica o vende al final de su ciclo de vida?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado'),
(21, '¿Mantiene acuerdos para compartir infraestructuras, equipamientos o logística con otras empresas/proveedores?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado'),
(22, '¿Ha gestionado iniciativas para compartir la gestión de residuos?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(23, '¿Ha desarrollado proyectos de innovación para la economía circular en cooperación con otras empresas, proveedores, centros educativos o tecnológicos, etc.?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(24, '¿En qué medida se compromete con sus proveedores para aumentar el abastecimiento basado en los principios de la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(25, '¿Colabora  interacciona con los clientes para avanzar en aspectos relacionados con la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(26, '¿Es miembro o participa activamente en iniciativas relacionadas con la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(27, '¿En que medida colabora o participa en iniciativas políticas para apoyar la transición hacia una economía circular (organizaciones comunitarias, municipio, GORE, etc.)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado'),
(28, '¿Se ha planteado eliminar el uso de envases/embalajes (no reciclables ni\r\nretornables)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(29, '¿Se ha planteado rediseñar su producto o servicio para aumentar la eficiencia en el uso de materias primas/energía a lo largo de su ciclo de vida?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(30, '¿Se ha planteado rediseñar su producto para aumentar su durabilidad o que sus componentes sean fácilmente extraíbles, sustituibles o reparables?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(31, '¿Se ha planteado rediseñar su producto o vender productos a granel, rellenables o con recargas para sustituir las partes consumibles?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(32, '¿En qué medida se han implementado herramientas y métricas para apoyar proyectos circulares de innovación/desarrollo?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(33, '¿Vende o fabrica productos elaborados con materias prima renovables y base biológica?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(34, '¿Vende o utilizan materia recursos fácilmente biodegradable\r\ncompostables?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(35, '¿Vende o utiliza materiales y productos reciclados?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(36, '¿Qué medidas de eficiencia energética lleva a cabo y cómo se evalúa y se implementa esa eficiencia energética en los procesos productivos?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(37, '¿Prioriza la compra de energía y combustibles renovables o de baja contaminación? (para transporte para sus vehículos, personal, etc.)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(38, '¿Produce energía renovable en sus instalaciones? (solar, eólica, etc.)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(39, '¿Calcula la huella de carbono de sus productos o servicios? ¿Incorpora iniciativas para reducir la huella de carbono de sus procesos productivos/servicios?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(40, '¿Se realiza un aprovechamiento energético de los residuos del proceso productivo? (en la propia actividad empresarial o para venta o entrega a externos)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(41, '¿Utiliza agua no potable (por ejemplo, de lluvia) en aplicaciones que lo permitan?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(42, '¿Reutiliza el agua de los procesos de producción?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(43, '¿Recupera los nutrientes, metales, productos químicos, calor y recursos valiosos similares, de las aguas residuales o de los lodos de depuración de sus procesos productivos, antes de su descarga? (para uso interno/externo)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(44, '¿Ha buscado reducir o eliminar el uso de agua en su modelo de negocio o fabricación?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica'),
(45, '¿Se reutilizan los materiales sobrantes o residuos del proceso de fabricación en el propio proceso productivo?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(46, '¿Se venden los residuos o subproductos generados en la actividad\r\nde la empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(47, '¿Mantiene, repara o actualiza los bienes, equipos, o mobiliario que utiliza la empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(48, '¿Adquiere o arrienda bienes, equipos o mobiliario de segunda mano o refabricados\r\npara el funcionamiento de su empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(49, '¿Recupera algunas partes de los bienes, equipos y mobiliario que utiliza en su quehacer para reparar otros bienes?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado'),
(50, '¿Contempla la venta, donación o reutilización de los bienes, equipos y mobiliario que utiliza en la empresa para otros fines, al final de su vida útil?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rut` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rut`, `nombre`, `correo`, `created_at`) VALUES
(1, '21.145.502-0', 'Mauricio', 'Mauricioguerrero14@gmail.com', '2025-02-11 20:21:00'),
(2, '22.123.323-4', 'Jose', 'jose@gmail.com', '2025-02-11 20:44:41'),
(3, '2114541329', 'mauricio', 'huerrer@kfaks.com', '2025-02-11 20:49:07'),
(5, '128312', 'miguel', 'huerrser@kfaks.com', '2025-02-11 20:53:05'),
(6, '123', 'jorge', 'huerrsr@kfaks.com', '2025-02-11 20:55:51'),
(9, '123213', 'manuel', 'jasdjas@asjda.com', '2025-02-12 20:52:34'),
(12, '211455020', 'Mauricio', 'Mauricioguerrero14@gmail.com', '2025-02-12 21:20:57'),
(13, '891238912aisodas', 'jasjkasjksadkj', 'kmasdkjasd@gmai.com', '2025-02-13 22:06:39');

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

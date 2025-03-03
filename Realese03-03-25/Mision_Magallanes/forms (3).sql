-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 03-03-2025 a las 19:15:58
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.1.31

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
) ENGINE=InnoDB AUTO_INCREMENT=1378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `answers`
--

INSERT INTO `answers` (`id`, `user_rut`, `question_id`, `selected_option`, `answered_at`) VALUES
(1228, '12389123', 8, 'A', '2025-03-03 19:05:35'),
(1229, '12389123', 9, 'A', '2025-03-03 19:05:35'),
(1230, '12389123', 10, 'A', '2025-03-03 19:05:35'),
(1231, '12389123', 11, 'A', '2025-03-03 19:05:35'),
(1232, '12389123', 1, 'A', '2025-03-03 19:05:43'),
(1233, '12389123', 2, 'A', '2025-03-03 19:05:43'),
(1234, '12389123', 3, 'A', '2025-03-03 19:05:43'),
(1235, '12389123', 4, 'A', '2025-03-03 19:05:43'),
(1236, '12389123', 5, 'A', '2025-03-03 19:05:43'),
(1237, '12389123', 6, 'A', '2025-03-03 19:05:43'),
(1238, '12389123', 7, 'A', '2025-03-03 19:05:43'),
(1239, '12389123', 12, 'A', '2025-03-03 19:05:50'),
(1240, '12389123', 13, 'A', '2025-03-03 19:05:50'),
(1241, '12389123', 14, 'A', '2025-03-03 19:05:50'),
(1242, '12389123', 15, 'A', '2025-03-03 19:05:50'),
(1243, '12389123', 16, 'A', '2025-03-03 19:05:50'),
(1244, '12389123', 17, 'A', '2025-03-03 19:05:50'),
(1245, '12389123', 18, 'A', '2025-03-03 19:05:53'),
(1246, '12389123', 19, 'A', '2025-03-03 19:05:53'),
(1247, '12389123', 20, 'A', '2025-03-03 19:05:53'),
(1248, '12389123', 21, 'A', '2025-03-03 19:06:01'),
(1249, '12389123', 22, 'A', '2025-03-03 19:06:01'),
(1250, '12389123', 23, 'A', '2025-03-03 19:06:01'),
(1251, '12389123', 24, 'A', '2025-03-03 19:06:01'),
(1252, '12389123', 25, 'A', '2025-03-03 19:06:01'),
(1253, '12389123', 26, 'A', '2025-03-03 19:06:01'),
(1254, '12389123', 27, 'A', '2025-03-03 19:06:01'),
(1255, '12389123', 28, 'A', '2025-03-03 19:06:07'),
(1256, '12389123', 29, 'A', '2025-03-03 19:06:07'),
(1257, '12389123', 30, 'A', '2025-03-03 19:06:07'),
(1258, '12389123', 31, 'A', '2025-03-03 19:06:07'),
(1259, '12389123', 32, 'A', '2025-03-03 19:06:07'),
(1260, '12389123', 33, 'A', '2025-03-03 19:06:10'),
(1261, '12389123', 34, 'A', '2025-03-03 19:06:10'),
(1262, '12389123', 35, 'A', '2025-03-03 19:06:10'),
(1263, '12389123', 36, 'A', '2025-03-03 19:06:16'),
(1264, '12389123', 37, 'A', '2025-03-03 19:06:16'),
(1265, '12389123', 38, 'A', '2025-03-03 19:06:16'),
(1266, '12389123', 39, 'A', '2025-03-03 19:06:16'),
(1267, '12389123', 40, 'A', '2025-03-03 19:06:16'),
(1268, '12389123', 41, 'A', '2025-03-03 19:06:20'),
(1269, '12389123', 42, 'A', '2025-03-03 19:06:20'),
(1270, '12389123', 43, 'A', '2025-03-03 19:06:20'),
(1271, '12389123', 44, 'A', '2025-03-03 19:06:20'),
(1272, '12389123', 45, 'A', '2025-03-03 19:06:22'),
(1273, '12389123', 46, 'A', '2025-03-03 19:06:22'),
(1274, '12389123', 47, 'A', '2025-03-03 19:06:26'),
(1275, '12389123', 48, 'A', '2025-03-03 19:06:26'),
(1276, '12389123', 49, 'A', '2025-03-03 19:06:26'),
(1277, '12389123', 50, 'A', '2025-03-03 19:06:26'),
(1278, '1283912', 8, 'A', '2025-03-03 19:07:11'),
(1279, '1283912', 9, 'A', '2025-03-03 19:07:11'),
(1280, '1283912', 10, 'A', '2025-03-03 19:07:11'),
(1281, '1283912', 11, 'A', '2025-03-03 19:07:11'),
(1282, '1283912', 1, 'A', '2025-03-03 19:07:21'),
(1283, '1283912', 2, 'A', '2025-03-03 19:07:21'),
(1284, '1283912', 3, 'A', '2025-03-03 19:07:21'),
(1285, '1283912', 4, 'A', '2025-03-03 19:07:21'),
(1286, '1283912', 5, 'A', '2025-03-03 19:07:21'),
(1287, '1283912', 6, 'A', '2025-03-03 19:07:21'),
(1288, '1283912', 7, 'A', '2025-03-03 19:07:21'),
(1289, '1283912', 12, 'A', '2025-03-03 19:07:27'),
(1290, '1283912', 13, 'A', '2025-03-03 19:07:27'),
(1291, '1283912', 14, 'A', '2025-03-03 19:07:27'),
(1292, '1283912', 15, 'A', '2025-03-03 19:07:27'),
(1293, '1283912', 16, 'A', '2025-03-03 19:07:27'),
(1294, '1283912', 17, 'A', '2025-03-03 19:07:27'),
(1295, '1283912', 18, 'A', '2025-03-03 19:07:30'),
(1296, '1283912', 19, 'A', '2025-03-03 19:07:30'),
(1297, '1283912', 20, 'A', '2025-03-03 19:07:30'),
(1298, '1283912', 21, 'A', '2025-03-03 19:07:38'),
(1299, '1283912', 22, 'A', '2025-03-03 19:07:38'),
(1300, '1283912', 23, 'A', '2025-03-03 19:07:38'),
(1301, '1283912', 24, 'A', '2025-03-03 19:07:38'),
(1302, '1283912', 25, 'A', '2025-03-03 19:07:38'),
(1303, '1283912', 26, 'A', '2025-03-03 19:07:38'),
(1304, '1283912', 27, 'A', '2025-03-03 19:07:38'),
(1305, '1283912', 28, 'A', '2025-03-03 19:07:45'),
(1306, '1283912', 29, 'A', '2025-03-03 19:07:45'),
(1307, '1283912', 30, 'A', '2025-03-03 19:07:45'),
(1308, '1283912', 31, 'A', '2025-03-03 19:07:45'),
(1309, '1283912', 32, 'A', '2025-03-03 19:07:45'),
(1310, '1283912', 33, 'A', '2025-03-03 19:07:49'),
(1311, '1283912', 34, 'A', '2025-03-03 19:07:49'),
(1312, '1283912', 35, 'A', '2025-03-03 19:07:49'),
(1313, '1283912', 36, 'A', '2025-03-03 19:07:56'),
(1314, '1283912', 37, 'A', '2025-03-03 19:07:56'),
(1315, '1283912', 38, 'A', '2025-03-03 19:07:56'),
(1316, '1283912', 39, 'A', '2025-03-03 19:07:56'),
(1317, '1283912', 40, 'A', '2025-03-03 19:07:56'),
(1318, '1283912', 41, 'A', '2025-03-03 19:08:01'),
(1319, '1283912', 42, 'A', '2025-03-03 19:08:01'),
(1320, '1283912', 43, 'A', '2025-03-03 19:08:01'),
(1321, '1283912', 44, 'A', '2025-03-03 19:08:01'),
(1322, '1283912', 45, 'A', '2025-03-03 19:08:03'),
(1323, '1283912', 46, 'A', '2025-03-03 19:08:03'),
(1324, '1283912', 47, 'A', '2025-03-03 19:08:08'),
(1325, '1283912', 48, 'A', '2025-03-03 19:08:08'),
(1326, '1283912', 49, 'A', '2025-03-03 19:08:08'),
(1327, '1283912', 50, 'A', '2025-03-03 19:08:08'),
(1328, '213512321', 8, 'A', '2025-03-03 19:10:33'),
(1329, '213512321', 9, 'A', '2025-03-03 19:10:33'),
(1330, '213512321', 10, 'A', '2025-03-03 19:10:33'),
(1331, '213512321', 11, 'A', '2025-03-03 19:10:33'),
(1332, '213512321', 1, 'A', '2025-03-03 19:10:41'),
(1333, '213512321', 2, 'B', '2025-03-03 19:10:41'),
(1334, '213512321', 3, 'C', '2025-03-03 19:10:41'),
(1335, '213512321', 4, 'A', '2025-03-03 19:10:41'),
(1336, '213512321', 5, 'D', '2025-03-03 19:10:41'),
(1337, '213512321', 6, 'A', '2025-03-03 19:10:41'),
(1338, '213512321', 7, 'C', '2025-03-03 19:10:41'),
(1339, '213512321', 12, 'A', '2025-03-03 19:10:47'),
(1340, '213512321', 13, 'D', '2025-03-03 19:10:47'),
(1341, '213512321', 14, 'B', '2025-03-03 19:10:47'),
(1342, '213512321', 15, 'A', '2025-03-03 19:10:47'),
(1343, '213512321', 16, 'D', '2025-03-03 19:10:47'),
(1344, '213512321', 17, 'B', '2025-03-03 19:10:47'),
(1345, '213512321', 18, 'A', '2025-03-03 19:10:49'),
(1346, '213512321', 19, 'D', '2025-03-03 19:10:49'),
(1347, '213512321', 20, 'A', '2025-03-03 19:10:49'),
(1348, '213512321', 21, 'C', '2025-03-03 19:10:56'),
(1349, '213512321', 22, 'A', '2025-03-03 19:10:56'),
(1350, '213512321', 23, 'B', '2025-03-03 19:10:56'),
(1351, '213512321', 24, 'C', '2025-03-03 19:10:56'),
(1352, '213512321', 25, 'A', '2025-03-03 19:10:56'),
(1353, '213512321', 26, 'D', '2025-03-03 19:10:56'),
(1354, '213512321', 27, 'B', '2025-03-03 19:10:56'),
(1355, '213512321', 28, 'A', '2025-03-03 19:11:00'),
(1356, '213512321', 29, 'B', '2025-03-03 19:11:00'),
(1357, '213512321', 30, 'D', '2025-03-03 19:11:00'),
(1358, '213512321', 31, 'B', '2025-03-03 19:11:00'),
(1359, '213512321', 32, 'A', '2025-03-03 19:11:00'),
(1360, '213512321', 33, 'C', '2025-03-03 19:11:03'),
(1361, '213512321', 34, 'A', '2025-03-03 19:11:03'),
(1362, '213512321', 35, 'A', '2025-03-03 19:11:03'),
(1363, '213512321', 36, 'C', '2025-03-03 19:11:08'),
(1364, '213512321', 37, 'A', '2025-03-03 19:11:08'),
(1365, '213512321', 38, 'D', '2025-03-03 19:11:08'),
(1366, '213512321', 39, 'A', '2025-03-03 19:11:08'),
(1367, '213512321', 40, 'A', '2025-03-03 19:11:08'),
(1368, '213512321', 41, 'D', '2025-03-03 19:11:11'),
(1369, '213512321', 42, 'A', '2025-03-03 19:11:11'),
(1370, '213512321', 43, 'C', '2025-03-03 19:11:11'),
(1371, '213512321', 44, 'A', '2025-03-03 19:11:11'),
(1372, '213512321', 45, 'A', '2025-03-03 19:11:13'),
(1373, '213512321', 46, 'C', '2025-03-03 19:11:13'),
(1374, '213512321', 47, 'A', '2025-03-03 19:11:17'),
(1375, '213512321', 48, 'B', '2025-03-03 19:11:17'),
(1376, '213512321', 49, 'A', '2025-03-03 19:11:17'),
(1377, '213512321', 50, 'B', '2025-03-03 19:11:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `image_url`) VALUES
(1, 'Aplicación de Herramientas y Tecnología', 'img/Herramientas_digitales.svg'),
(2, 'Política y Estrategia de Economía Circular', 'img/Economia_circular.svg'),
(3, 'Digitalización y Operaciones', 'img/Digitalización_operaciones.svg'),
(4, 'Nuevos Negocios', 'img/Nuevos_negocios.svg'),
(5, 'Compromiso externo y cooperación empresarial', 'img/Compromiso_externo.svg'),
(6, 'Innovación y diseño', 'img/Innovacion.svg'),
(7, 'Recursos materiales', 'img/Recursos_materiales.svg'),
(8, 'Recursos energéticos', 'img/Recursos_energeticos.svg'),
(9, 'Uso del agua', 'img/Uso_del_agua.svg'),
(10, 'Valorización de los flujos de residuos', 'img/Flujo_residual.svg'),
(11, 'Optimización de vida útil de activos y productos', 'img/Optimizacion_vida_util.svg');

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
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `category_id`) VALUES
(1, '¿Ha integrado en su política de empresa un plan o estrategia de transición a la economía circular?\r\n¿Su estrategia está alineada con volverse más circular?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado al menos 1 iniciativa', 'No se ha considerado', 2),
(2, '¿Analiza o gestiona los riesgos y las oportunidades de negocio asociadas a la economía circular? ¿Analiza los riesgos de permanecer en una economía lineal?', 'Política Integrada en los procedimientos', 'En fase de desarrollo', 'Se ha considerado', 'No se ha considerado', 2),
(3, '¿Tiene objetivos de economía circular medibles?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado', 2),
(4, '¿Dispone de un presupuesto para sus iniciativas de economía circular?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado', 2),
(5, '¿Cuenta con alguna ayuda financiera o subsidio de apoyo a la economía circular/eficiencia energética?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado', 2),
(6, '¿Ha lanzado alguna campaña de sensibilización sobre la economía circular (comunicaciones a nivel interno o externo)?', 'En fase operativa(>25%prod/serv)', 'En desarrollo (<25%prod/serv)', 'Se ha considerado para al menos 1 iniciativa', 'No se ha considerado', 2),
(7, '¿Incorpora actividades de formación en economía circular entre sus colaboradores/trabajadores?', 'Plan integrado y en operación', 'En desarrollo plan y aplicación', 'Se ha coniderado al menos 1 iniciativa', 'No se ha considerado', 2),
(8, '¿Ha implementado un sistema de gestión ambiental  de \"cero residuos\", o utiliza alguna herramienta para alcanzar ese objetivo?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase  experimental', 'No se ha considerado ( o no aplica)', 1),
(9, '¿Utiliza alguna herramienta para evaluar el impacto ambiental de sus productos/servicios (Por ejemplo, Análisis de Ciclo de Vida, ACV)?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado está en fase experimental', 'No se ha considerado (o no aplica)', 1),
(10, '¿Contempla aspectos ambientales o ecológicos en el diseño de sus productos/servicios?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase experimental', 'No se ha considerado (o no aplica)', 1),
(11, '¿Utiliza algún tipo de \"ecoetiquetado\" (ela hídrica, ...) en sus productos o servicios?', 'En fase operativa(>25%prod/serv)', 'En desarrollo plan y aplicación', 'Se ha considerado, está en fase experimental', 'No se ha considerado (o no aplica)', 1),
(12, '¿Mantiene un espacio de trabajo de (coworking, teletrabajo, servicios en la nube, etc.)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(13, '¿Ha implantado la industria o servicios 4.0 para optimizar el uso/suministro de materias primas/energía o prevenir la generación de residuos?(por ejemplo, automatización, uso de sensores, etc.)', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(14, '¿En que medida su empresa esta implementando sistemas digitales para apoyar productos o servicios circulares?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(15, '¿En qué medida su empresa está implementando sistemas digitales para optimizar los procesos de operación de la empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(16, '¿Ha digitalizado documentos tales como precedimientos de trabajo, reportes o manuales de instrucciones de producto, sustituyendo los formatos en papel?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(17, '¿Prioriza el uso de campañas publicitarias o comunicaciones digitales, sustituyendo a la publicidad o correspondencia en soporte físico?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado, está en fase experimental', 'No se ha considerado', 3),
(18, '¿Considera el mantenimiento/reparación/venta de piezas de repuesto de sus productos como parte de las lineas de negocio de su empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado', 4),
(19, '¿Incluye la venta de productos de segunda mano como una linea de negocio en su empresa?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado', 4),
(20, '¿Promueve o participa en iniciativas para la recogida parcial o total de los productos que fabrica o vende al final de su ciclo de vida?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado', 4),
(21, '¿Mantiene acuerdos para compartir infraestructuras, equipamientos o logística con otras empresas/proveedores?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o está en fase experimental', 'No se ha considerado', 5),
(22, '¿Ha gestionado iniciativas para compartir la gestión de residuos?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(23, '¿Ha desarrollado proyectos de innovación para la economía circular en cooperación con otras empresas, proveedores, centros educativos o tecnológicos, etc.?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(24, '¿En qué medida se compromete con sus proveedores para aumentar el abastecimiento basado en los principios de la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(25, '¿Colabora  interacciona con los clientes para avanzar en aspectos relacionados con la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(26, '¿Es miembro o participa activamente en iniciativas relacionadas con la economía circular?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(27, '¿En que medida colabora o participa en iniciativas políticas para apoyar la transición hacia una economía circular (organizaciones comunitarias, municipio, GORE, etc.)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado  al menos 1 iniciativa', 'No se ha considerado', 5),
(28, '¿Se ha planteado eliminar el uso de envases/embalajes (no reciclables ni\r\nretornables)?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 6),
(29, '¿Se ha planteado rediseñar su producto o servicio para aumentar la eficiencia en el uso de materias primas/energía a lo largo de su ciclo de vida?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 6),
(30, '¿Se ha planteado rediseñar su producto para aumentar su durabilidad o que sus componentes sean fácilmente extraíbles, sustituibles o reparables?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 6),
(31, '¿Se ha planteado rediseñar su producto o vender productos a granel, rellenables o con recargas para sustituir las partes consumibles?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 6),
(32, '¿En qué medida se han implementado herramientas y métricas para apoyar proyectos circulares de innovación/desarrollo?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 6),
(33, '¿Vende o fabrica productos elaborados con materias prima renovables y base biológica?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 7),
(34, '¿Vende o utilizan materia recursos fácilmente biodegradable\r\ncompostables?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 7),
(35, '¿Vende o utiliza materiales y productos reciclados?', 'En fase operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 7),
(36, '¿Qué medidas de eficiencia energética lleva a cabo y cómo se evalúa y se implementa esa eficiencia energética en los procesos productivos?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 8),
(37, '¿Prioriza la compra de energía y combustibles renovables o de baja contaminación? (para transporte para sus vehículos, personal, etc.)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 8),
(38, '¿Produce energía renovable en sus instalaciones? (solar, eólica, etc.)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 8),
(39, '¿Calcula la huella de carbono de sus productos o servicios? ¿Incorpora iniciativas para reducir la huella de carbono de sus procesos productivos/servicios?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 8),
(40, '¿Se realiza un aprovechamiento energético de los residuos del proceso productivo? (en la propia actividad empresarial o para venta o entrega a externos)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 8),
(41, '¿Utiliza agua no potable (por ejemplo, de lluvia) en aplicaciones que lo permitan?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 9),
(42, '¿Reutiliza el agua de los procesos de producción?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 9),
(43, '¿Recupera los nutrientes, metales, productos químicos, calor y recursos valiosos similares, de las aguas residuales o de los lodos de depuración de sus procesos productivos, antes de su descarga? (para uso interno/externo)', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 9),
(44, '¿Ha buscado reducir o eliminar el uso de agua en su modelo de negocio o fabricación?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado/No aplica', 9),
(45, '¿Se reutilizan los materiales sobrantes o residuos del proceso de fabricación en el propio proceso productivo?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 10),
(46, '¿Se venden los residuos o subproductos generados en la actividad\r\nde la empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 10),
(47, '¿Mantiene, repara o actualiza los bienes, equipos, o mobiliario que utiliza la empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 11),
(48, '¿Adquiere o arrienda bienes, equipos o mobiliario de segunda mano o refabricados\r\npara el funcionamiento de su empresa?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 11),
(49, '¿Recupera algunas partes de los bienes, equipos y mobiliario que utiliza en su quehacer para reparar otros bienes?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 11),
(50, '¿Contempla la venta, donación o reutilización de los bienes, equipos y mobiliario que utiliza en la empresa para otros fines, al final de su vida útil?', 'Operativa(>25%prod/serv)', 'En fase desarrollo(<25%prod/serv)', 'Se ha considerado o en fase experimental', 'No se ha considerado', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rut` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre_representante` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cargo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nombre_empresa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rut`, `nombre_representante`, `cargo`, `nombre_empresa`, `correo`, `created_at`) VALUES
(1, '12332312239', 'Juan', 'Gerente', 'Aqua', 'Juan@Aqua.com', '2025-02-27 19:42:08'),
(34, '1123123', 'Jorge', 'Gerente', 'Aqua', 'jorge@aqua.com', '2025-02-27 20:20:52'),
(35, '1238912983', 'Jose', 'Gerente', 'Aqua', 'Jose@aqua.com', '2025-02-27 20:24:32'),
(36, '12312938', 'Manuel', 'Gerente', 'Aqua', 'Manuel@aqua.com', '2025-02-27 21:45:46'),
(37, '128391293', 'DobleA', 'ReyDelTrap', 'Anuel', 'Anuel@brr.com', '2025-02-28 15:18:14'),
(38, '1238912', 'Manuel', 'Gerente', 'Aqua', 'Manuel@aqua.com', '2025-02-28 16:47:24'),
(39, '123132123', 'Miguel', 'Gerente', 'Aqua2', 'Miguel@aqua2.com', '2025-02-28 19:02:56'),
(40, '1283292', 'Mauro', 'Gerente', 'Kreative', 'Kreative@kreative.com', '2025-02-28 19:07:24'),
(41, '12389123', 'Claudio', 'Encargado', 'Unimarc', 'Claudio@unimarc.cl', '2025-02-28 19:51:20'),
(42, '1283912', 'Mauricio', 'Gerente', 'Chamaking', 'mauricioguerrero14@gmail.com', '2025-02-28 21:22:35'),
(43, '12893123', 'Joseph', 'Gerente', 'Jefasos', 'Joseph@jefasos.com', '2025-03-03 16:13:15'),
(44, '182931', 'askoassadko', 'asdoi', 'Jefardo', 'paladinsql77@gmail.com', '2025-03-03 17:05:04'),
(45, '213512321', 'Fernando', 'Gerente', 'Verra', 'fernandovelasquezprieto@gmail.com', '2025-03-03 19:10:27');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);

--
-- Filtros para la tabla `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

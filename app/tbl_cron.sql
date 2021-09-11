-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-09-2021 a las 15:47:06
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `abc_cron_control`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cron`
--

CREATE TABLE `tbl_cron` (
  `ID` int(11) NOT NULL,
  `argumento` varchar(50) NOT NULL,
  `time` int(11) NOT NULL,
  `estado` tinyint(4) NOT NULL,
  `app` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_cron`
--

INSERT INTO `tbl_cron` (`ID`, `argumento`, `time`, `estado`, `app`, `created`) VALUES
(1, 'InsertJsonGrupo1', 1631047624, 1, 'Productividad', '2021-09-07 20:47:04'),
(2, 'InsertJsonGrupo2', 1631047624, 0, 'Productividad', '2021-09-07 20:47:06'),
(3, 'InsertJsonGrupo3', 1631047625, 1, 'Productividad', '2021-09-07 20:47:05'),
(4, 'InsertJsonGrupo4', 1631047625, 1, 'Productividad', '2021-09-07 20:47:05'),
(5, 'InsertJsonGrupo5', 1631047620, 0, 'Productividad', '2021-09-07 20:47:02'),
(6, 'InsertJsonGrupo6', 1631047616, 0, 'Productividad', '2021-09-07 20:46:56'),
(7, 'InsertJsonGrupo7', 1631047621, 1, 'Productividad', '2021-09-07 20:47:01'),
(8, 'InsertJsonGrupo8', 1631047622, 1, 'Productividad', '2021-09-07 20:47:02'),
(9, 'Procesarfacturacion999', 1631047611, 0, 'Facturacion', '2021-09-07 20:46:51'),
(10, 'EnviarFacturasApi999', 1631047611, 0, 'Facturacion', '2021-09-07 20:46:51'),
(11, 'EnviarPDF999', 1631047612, 0, 'Facturacion', '2021-09-07 20:46:56'),
(12, 'TransmitirFacts999', 1631047612, 0, 'Facturacion', '2021-09-07 20:46:52'),
(13, 'EnviadoOk999', 1631047626, 0, 'Facturacion', '2021-09-07 20:47:06'),
(14, 'ConsultarFacturas999', 1631044510, 1, 'Facturacion', '2021-09-07 19:55:10'),
(15, 'AsociarDocumentos12', 1630600403, 0, 'Facturacion', '2021-09-02 16:33:23'),
(16, 'ActualizarPdf999', 1631047613, 0, 'Facturacion', '2021-09-07 20:46:53'),
(17, 'SendMailCargueTRK999', 1631047614, 0, 'Facturacion', '2021-09-07 20:46:54'),
(18, 'FileSoporteVencido999', 1631047615, 0, 'Facturacion', '2021-09-07 20:47:05');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_cron`
--
ALTER TABLE `tbl_cron`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `argumento` (`argumento`),
  ADD KEY `estado` (`estado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_cron`
--
ALTER TABLE `tbl_cron`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

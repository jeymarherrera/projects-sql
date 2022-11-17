
CREATE DATABASE FarmaciaEGP;
USE FarmaciaEGP;

-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `Nombre` varchar(250) NOT NULL,
  `FechaCreacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `Nombre`, `FechaCreacion`) VALUES
(1, 'YEREIKA PROUT', '2021-06-23 20:40:40'),
(2, 'ANGEL GALLARDO', '2021-06-23 20:40:40'),
(3, 'ADINA WAITHE', '2021-06-23 20:40:40'),
(4, 'CHRISTY CRUZ', '2021-06-23 20:40:40'),
(5, 'ARIEL CEDENO', '2021-06-23 20:40:40'),
(6, 'CRISTIAN GORDON', '2021-06-23 20:40:40'),
(7, 'SERGIO ORTIZ', '2021-06-23 20:40:40'),
(8, 'YAMILKA DANIELS', '2021-06-23 20:40:40'),
(9, 'KATHERINE DANIELS', '2021-06-23 20:40:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_facturas`
--

CREATE TABLE `detalle_facturas` (
  `id` int(12) NOT NULL,
  `num_factura` int(12) NOT NULL,
  `num_detalle` int(4) NOT NULL,
  `medicamento` int(11) NOT NULL,
  `cantidad` int(4) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `fechaCreacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_facturas`
--

INSERT INTO `detalle_facturas` (`id`, `num_factura`, `num_detalle`, `medicamento`, `cantidad`, `precio`, `fechaCreacion`) VALUES
(1, 210615001, 1, 2, 10, '0.72', '2021-06-23 21:11:40'),
(2, 210615001, 2, 9, 1, '3.04', '2021-06-23 21:11:40'),
(3, 210615001, 3, 28, 2, '7.23', '2021-06-23 21:11:40'),
(4, 210615002, 1, 69, 3, '7.96', '2021-06-23 21:11:40'),
(5, 210615002, 2, 37, 20, '0.91', '2021-06-23 21:11:40'),
(6, 210615002, 3, 29, 30, '0.13', '2021-06-23 21:11:40'),
(7, 210615002, 4, 4, 15, '1.14', '2021-06-23 21:11:40'),
(8, 210615003, 1, 17, 2, '12.59', '2021-06-23 21:11:40'),
(9, 210615003, 2, 37, 10, '0.91', '2021-06-23 21:11:40'),
(10, 210615004, 1, 2, 30, '0.72', '2021-06-23 21:11:40'),
(11, 210615005, 1, 59, 1, '26.23', '2021-06-23 21:11:40'),
(12, 210615005, 2, 28, 1, '7.23', '2021-06-23 21:11:40'),
(13, 210615005, 3, 5, 1, '25.77', '2021-06-23 21:11:40'),
(14, 210615005, 4, 37, 12, '0.91', '2021-06-23 21:11:40'),
(15, 210615005, 5, 2, 7, '0.72', '2021-06-23 21:11:40'),
(16, 210615006, 1, 29, 15, '0.13', '2021-06-23 21:11:40'),
(17, 210615006, 2, 14, 1, '10.80', '2021-06-23 21:11:40'),
(18, 210615007, 1, 37, 25, '0.91', '2021-06-23 21:11:40'),
(19, 210615008, 1, 59, 1, '26.23', '2021-06-23 21:11:40'),
(20, 210615008, 2, 4, 15, '1.14', '2021-06-23 21:11:40'),
(21, 210615009, 1, 9, 1, '3.04', '2021-06-23 21:11:40'),
(22, 210615009, 2, 28, 2, '7.23', '2021-06-23 21:11:40'),
(23, 210615009, 3, 69, 3, '7.96', '2021-06-23 21:11:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `num_factura` int(12) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `fechaCreacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`num_factura`, `id_cliente`, `fecha`, `fechaCreacion`) VALUES
(210615001, 1, '2021-06-23', '2021-06-23 20:50:34'),
(210615002, 2, '2021-06-23', '2021-06-23 20:50:34'),
(210615003, 3, '2021-06-23', '2021-06-23 20:50:34'),
(210615004, 4, '2021-06-23', '2021-06-23 20:50:34'),
(210615005, 5, '2021-06-23', '2021-06-23 20:50:34'),
(210615006, 6, '2021-06-23', '2021-06-23 20:50:34'),
(210615007, 7, '2021-06-23', '2021-06-23 20:50:34'),
(210615008, 8, '2021-06-23', '2021-06-23 20:50:34'),
(210615009, 9, '2021-06-23', '2021-06-23 20:50:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id_medica` int(11) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `Activo` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id_medica`, `Descripcion`, `Precio`, `Activo`) VALUES
(1, 'AMOXICILINA  250 mg/5ml ', '12.18', 1),
(2, 'AMOXICILINA BASE O TRIHIDRATADA 500 mg cápsula', '0.72', 1),
(3, 'AZITROMICINA 500 mg cápsula ', '15.24', 1),
(4, 'CEFALEXINA 500 mg cápsula', '1.14', 1),
(5, 'CEFTRIAXONA SÓDICA 1 gramo I.M. vial', '25.77', 1),
(6, 'CIPROFLOXACINA, 500 mg tableta', '5.52', 1),
(7, 'NITROFURANTOINA 100 mg cápsula', '1.12', 1),
(8, 'TRIMETROPIN CON SULFA  40mg ', '19.53', 1),
(9, 'FLUOXETINA 20mg tableta', '3.04', 1),
(10, 'QUETIAPINA FUMARATO 100 mg tableta ', '2.57', 1),
(11, 'DULOXETINA CLORHIDRATO 60 mg cápsula', '4.22', 1),
(12, 'OLANZAPINA 10 mg comprimido dispensable', '10.26', 1),
(13, 'TIMOLOL 0.5% Gotas Oftálmicas, frasco     2.5 - 5 ml', '36.42', 1),
(14, 'GENTAMICINA 0.3%  Gotas Oftálmicas, frasco 5 -10 ml', '10.80', 1),
(15, 'ALBENDAZOL 40 mg/ml suspensión, frasco 10 ml', '4.55', 1),
(16, 'ALBENDAZOL 200 mg comprimidos', '1.28', 1),
(17, 'HIDROCORTISONA 1% crema tópica tubo 15 gr', '12.59', 1),
(18, 'CLOTRIMAZOL crema tópica 1%, tubo 15-20 gr', '9.40', 1),
(19, 'AMLODIPINA 5 mg tableta ', '1.67', 1),
(20, 'ATENOLOL 100mg comprimidos ranurados ', '0.97', 1),
(21, 'ENALAPRIL 20 mg tableta', '1.78', 1),
(22, 'SIMVASTATINA 20  mg cápsula o comprimido', '3.16', 1),
(23, 'IRBESARTÁN, 300 mg Tabletas ', '2.56', 1),
(24, 'METRONIDAZOL 500 mg óvulo vaginal', '2.00', 1),
(25, 'DICLOFENACO  9 mg/5 ml suspensión, frasco 120 ml', '9.73', 1),
(26, 'DICLOFENACO SODICO 50 mg tableta, cápsula o comprimido', '1.18', 1),
(27, 'IBUPROFENO 400 mg gragea o comprimido', '0.58', 1),
(28, 'PARACETAMOL  120 - 160mg/5ml Tableta', '7.23', 1),
(29, 'PARACETAMOL  500mg, tableta o comprimido', '0.13', 1),
(30, 'AMBROXOL CLORHIDRATO 15mg/5ml jarabe, frasco 120 ml', '9.33', 1),
(31, 'LORATADINA 10 mg comprimido', '1.32', 1),
(32, 'BECLOMETASONA DIPROPIONATO 50 mcg/inhalación, solución inhalador, Frasco 100-200 dosis', '21.64', 1),
(33, 'SALBUTAMOL BASE O SULFATO AEROSOL libre de CFC, equivalente a 100MCG por inhalación, Frasco 200 - 250 dosis ', '11.03', 1),
(34, 'GLIBENCLAMIDA 5 mg comprimido ', '0.55', 1),
(35, 'HIDROXIDO DE ALUMINIO Y MAGNESIO 5.9 - 8.3%', '7.03', 1),
(36, 'METFORMINA CLORHIDRATO 850 mg tableta ranurada', '0.70', 1),
(37, ' OMEPRAZOL 20 mg cápsula con microesferas gastroresistente ', '0.91', 1),
(38, 'RANITIDINA CLORHIDRATO  150 mg  tableta o comprimido ', '1.10', 1),
(39, 'SALES DE REHIDRATACIÓN LÍQUIDO, Frasco 400-500 ml', '3.69', 1),
(40, 'GLICLAZIDA 80 MG Tabletas', '0.56', 1),
(41, 'SITAGLIPTINA 100 MG Tabletas', '2.48', 1),
(42, 'ISOSORBIDE DINITRATO 10 MG Tabletas', '0.22', 1),
(43, 'AMIODARONA CLORHIDRATO 40 MG Tabletas', '0.77', 1),
(44, 'PROPRANOLOL CLORHIDRATO 40 MG Tabletas ', '0.23', 1),
(45, 'CARVEDILOL 6.25 MG Tabletas ', '0.65', 1),
(46, 'FUROSEMIDA 40 MG Tabletas ', '0.90', 1),
(47, 'IRBESARTÁN, 150 mg Tabletas ', '2.47', 1),
(48, 'LISINOPRIL 20 MG Tabletas ', '1.25', 1),
(49, 'PERINDOPRIL 5 MG Tabletas', '1.68', 1),
(50, 'VERAPAMILO CLORHIDRATO 80 MG Tabletas', '0.68', 1),
(51, 'ROSUVASTATINA 10 MG Tabletas ', '2.77', 1),
(52, 'CETIRIZINA 10 MG Tabletas', '0.53', 1),
(53, 'DESLORATADINA 5MG Tabletas', '2.18', 1),
(54, 'DIFENHIDRAMINA 12.5 MG/5 ML JARABE  FRASCO 120ML', '5.94', 1),
(55, 'SALBUTAMOL 2 MG/5 ML SOLUCIÓN ', '14.26', 1),
(56, 'PREDNISONA 5 MG TABLETAS', '1.00', 1),
(57, 'DEXTROMETORFANO BROMHIDRATO 2 MG/ML JARABE 27mg/15ml FRASCO 120 - 200ML', '10.96', 1),
(58, 'SIMETICONA 40 MG TABLETAS ', '0.25', 1),
(59, 'LACTULOSA 667 MG/ML JARABE  FRASCO 125ML', '26.23', 1),
(60, 'ISOCONAZOL NITRATO 600 MG ÓVULO VAGINAL ', '19.42', 1),
(61, 'ACICLOVIR 5% CREMA TÓPICA', '13.00', 1),
(62, 'ACICLOVIR 400 MG TABLETAS', '3.17', 1),
(63, 'FUSIDATO SÓDICO 2% UNGÜENTO TUBO 15G', '13.32', 1),
(64, 'CLORHEXIDINA GLUCONATO 4% SOLUCIÓN 240 ML', '11.14', 1),
(65, 'SULFADIAZINA DE PLATA 1% CREMA TÓPICA ', '6.77', 1),
(66, 'CALAMINA 8.00% LOCIÓN 180 ML', '5.85', 1),
(67, 'PERMETRINA 5% LOCIÓN  60G', '10.14', 1),
(68, 'PROTECTOR SOLAR ', '34.37', 1),
(69, 'LEVOFLOXACINA 500 MG TABLETAS ', '7.96', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle_facturas`
--
ALTER TABLE `detalle_facturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_PersonOrder` (`num_factura`),
  ADD KEY `FK_id_medicamentos` (`medicamento`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`num_factura`),
  ADD KEY `FK_id_cliente` (`id_cliente`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id_medica`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `detalle_facturas`
--
ALTER TABLE `detalle_facturas`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `id_medica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_facturas`
--
ALTER TABLE `detalle_facturas`
  ADD CONSTRAINT `FK_PersonOrder` FOREIGN KEY (`num_factura`) REFERENCES `facturas` (`num_factura`),
  ADD CONSTRAINT `FK_id_medicamentos` FOREIGN KEY (`medicamento`) REFERENCES `medicamentos` (`id_medica`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `FK_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);
COMMIT;


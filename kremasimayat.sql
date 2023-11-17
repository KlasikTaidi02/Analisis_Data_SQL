SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kremasimayat`
--
CREATE Database kremasimayat; 
-- --------------------------------------------------------

--
-- Table structure for table `datamayat`
--

CREATE TABLE `datamayat` (
  `id_Mayat` int(10) NOT NULL,
  `namaMayat` varchar(10) NOT NULL,
  `nomorTelepon` varchar(100) NOT NULL,
  `tglMasuk` date NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'Belum dikremasi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `konsumen`
--

CREATE TABLE `konsumen` (
  `id_Konsumen` int(10) NOT NULL,
  `usernameKonsumen` varchar(100) NOT NULL,
  `passwordKonsumen` varchar(100) NOT NULL,
  `namaKonsumen` varchar(100) NOT NULL,
  `nomorTelepon` varchar(12) NOT NULL,
  `jumlahMayat` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kremasi`
--

CREATE TABLE `kremasi` (
  `id_Kremasi` int(10) NOT NULL,
  `id_Mayat` int(10) NOT NULL,
  `id_Konsumen` int(10) NOT NULL,
  `id_Pembayaran` int(10) NOT NULL,
  `id_Pegawai` int(10) NOT NULL,
  `id_Layanan` int(10) NOT NULL,
  `waktuKremasi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `layanan`
--

CREATE TABLE `layanan` (
  `idLayanan` int(10) NOT NULL,
  `namaLayanan` int(100) NOT NULL,
  `hargaLayanan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_Pegawai` int(10) NOT NULL,
  `usernamePegawai` varchar(100) NOT NULL,
  `paswordPegawai` varchar(100) NOT NULL,
  `namaPegawai` varchar(100) NOT NULL,
  `noHP` varchar(100) NOT NULL,
  `tanggalMasuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(10) NOT NULL,
  `tanggalPembayaran` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `datamayat`
--
ALTER TABLE `datamayat`
  ADD PRIMARY KEY (`id_Mayat`),
  ADD KEY `namaMayat` (`namaMayat`);

--
-- Indexes for table `konsumen`
--
ALTER TABLE `konsumen`
  ADD PRIMARY KEY (`id_Konsumen`),
  ADD KEY `namaKonsumen` (`namaKonsumen`);

--
-- Indexes for table `kremasi`
--
ALTER TABLE `kremasi`
  ADD PRIMARY KEY (`id_Kremasi`),
  ADD KEY `id_Mayat` (`id_Mayat`,`id_Konsumen`) USING BTREE,
  ADD KEY `fk_konsumen` (`id_Konsumen`),
  ADD KEY `fk_pembayaran` (`id_Pembayaran`),
  ADD KEY `fk_pegawai` (`id_Pegawai`),
  ADD KEY `fk_layanan` (`id_Layanan`);

--
-- Indexes for table `layanan`
--
ALTER TABLE `layanan`
  ADD PRIMARY KEY (`idLayanan`),
  ADD KEY `namaLayanan` (`namaLayanan`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_Pegawai`),
  ADD KEY `namaPegawai` (`namaPegawai`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kremasi`
--
ALTER TABLE `kremasi`
  ADD CONSTRAINT `fk_konsumen` FOREIGN KEY (`id_Konsumen`) REFERENCES `konsumen` (`id_Konsumen`),
  ADD CONSTRAINT `fk_layanan` FOREIGN KEY (`id_Layanan`) REFERENCES `layanan` (`idLayanan`),
  ADD CONSTRAINT `fk_mayat` FOREIGN KEY (`id_Mayat`) REFERENCES `datamayat` (`id_Mayat`),
  ADD CONSTRAINT `fk_pegawai` FOREIGN KEY (`id_Pegawai`) REFERENCES `pegawai` (`id_Pegawai`),
  ADD CONSTRAINT `fk_pembayaran` FOREIGN KEY (`id_Pembayaran`) REFERENCES `pembayaran` (`id_pembayaran`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

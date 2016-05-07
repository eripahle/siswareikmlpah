-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 07 Mei 2016 pada 12.24
-- Versi Server: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sistem_warehouse`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `ID_BARANG` char(50) NOT NULL,
  `NAMA_BARANG` char(50) NOT NULL,
  `HARGA_BARANG` bigint(20) NOT NULL,
  `STOK` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_transaksi`
--

CREATE TABLE IF NOT EXISTS `detail_transaksi` (
  `ID_BARANG` char(50) DEFAULT NULL,
  `ID_TRANSAKSI` char(50) DEFAULT NULL,
  `JUMLAH` bigint(20) NOT NULL,
  `SUBTOTAL` bigint(20) NOT NULL,
  `STATUS_BARANG_TRANSAKSI` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `ID_OPERATOR` char(50) DEFAULT NULL,
  `AKTIFITAS` text NOT NULL,
  `TIMESTAMP_LOG` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `operator`
--

CREATE TABLE IF NOT EXISTS `operator` (
  `ID_OPERATOR` char(50) NOT NULL,
  `NAMA_OPERATOR` char(50) NOT NULL,
  `JENIS_OPERATOR` int(1) NOT NULL,
  `USER_OPERATOR` varchar(20) NOT NULL,
  `PASS_OPERATOR` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `operator`
--

INSERT INTO `operator` (`ID_OPERATOR`, `NAMA_OPERATOR`, `JENIS_OPERATOR`, `USER_OPERATOR`, `PASS_OPERATOR`) VALUES
('1', 'Pahelvi Ridwan', 0, 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `ID_SALES` char(50) NOT NULL,
  `NAMA_SALES` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE IF NOT EXISTS `transaksi` (
  `ID_TRANSAKSI` char(50) NOT NULL,
  `ID_SALES` char(50) DEFAULT NULL,
  `ID_OPERATOR` char(50) DEFAULT NULL,
  `TIMESTAMP_TRX` datetime NOT NULL,
  `TOTAL` bigint(20) NOT NULL,
  `STATUS_TRX` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_lanjutan`
--

CREATE TABLE IF NOT EXISTS `transaksi_lanjutan` (
  `ID_TRANSAKSI_LANJUTAN` char(50) NOT NULL,
  `ID_SALES` char(50) DEFAULT NULL,
  `ID_OPERATOR` char(50) DEFAULT NULL,
  `ID_TRANSAKSI` char(50) DEFAULT NULL,
  `TIMESTAMP_TRX_LANJUTAN` datetime NOT NULL,
  `BAYAR_TRX_LANJUTAN` bigint(20) NOT NULL,
  `SISA_TRX_LANJUTAN` bigint(20) NOT NULL,
  `IDENTIFIKASI_DETAIL_BARANG` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
 ADD PRIMARY KEY (`ID_BARANG`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
 ADD KEY `FK_BARANG_TO_DETAIL_TRANSAKSI` (`ID_BARANG`), ADD KEY `FK_TRANSAKSI_TO_DETAIL_TRANSAKSI` (`ID_TRANSAKSI`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
 ADD KEY `FK_OPERATOR_TO_LOG` (`ID_OPERATOR`);

--
-- Indexes for table `operator`
--
ALTER TABLE `operator`
 ADD PRIMARY KEY (`ID_OPERATOR`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
 ADD PRIMARY KEY (`ID_SALES`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
 ADD PRIMARY KEY (`ID_TRANSAKSI`), ADD KEY `FK_OPERATOR_TO_TRANSAKSI` (`ID_OPERATOR`), ADD KEY `FK_SALES_TO_TRANSAKSI` (`ID_SALES`);

--
-- Indexes for table `transaksi_lanjutan`
--
ALTER TABLE `transaksi_lanjutan`
 ADD PRIMARY KEY (`ID_TRANSAKSI_LANJUTAN`), ADD KEY `FK_OPERATOR_TO_TRANSAKSI_LANJUTAN` (`ID_OPERATOR`), ADD KEY `FK_SALES_TO_TRANSAKSI_LANJUTAN` (`ID_SALES`), ADD KEY `FK_TRANSAKSI_TO_TRANSAKSI_LANJUTAN` (`ID_TRANSAKSI`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
ADD CONSTRAINT `FK_BARANG_TO_DETAIL_TRANSAKSI` FOREIGN KEY (`ID_BARANG`) REFERENCES `barang` (`ID_BARANG`),
ADD CONSTRAINT `FK_TRANSAKSI_TO_DETAIL_TRANSAKSI` FOREIGN KEY (`ID_TRANSAKSI`) REFERENCES `transaksi` (`ID_TRANSAKSI`);

--
-- Ketidakleluasaan untuk tabel `log`
--
ALTER TABLE `log`
ADD CONSTRAINT `FK_OPERATOR_TO_LOG` FOREIGN KEY (`ID_OPERATOR`) REFERENCES `operator` (`ID_OPERATOR`);

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
ADD CONSTRAINT `FK_OPERATOR_TO_TRANSAKSI` FOREIGN KEY (`ID_OPERATOR`) REFERENCES `operator` (`ID_OPERATOR`),
ADD CONSTRAINT `FK_SALES_TO_TRANSAKSI` FOREIGN KEY (`ID_SALES`) REFERENCES `sales` (`ID_SALES`);

--
-- Ketidakleluasaan untuk tabel `transaksi_lanjutan`
--
ALTER TABLE `transaksi_lanjutan`
ADD CONSTRAINT `FK_OPERATOR_TO_TRANSAKSI_LANJUTAN` FOREIGN KEY (`ID_OPERATOR`) REFERENCES `operator` (`ID_OPERATOR`),
ADD CONSTRAINT `FK_SALES_TO_TRANSAKSI_LANJUTAN` FOREIGN KEY (`ID_SALES`) REFERENCES `sales` (`ID_SALES`),
ADD CONSTRAINT `FK_TRANSAKSI_TO_TRANSAKSI_LANJUTAN` FOREIGN KEY (`ID_TRANSAKSI`) REFERENCES `transaksi` (`ID_TRANSAKSI`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

WITH m1 AS (
SELECT 
nama_cabang,tp.kode_cabang,
tp.tgl_transaksi,
mhh.harga_berlaku_cabang,mhh.modal_cabang ,mhh.biaya_cabang, tp.jumlah_pembelian

FROM tr_penjualan tp 
JOIN ms_harga_harian mhh ON tp.kode_produk = mhh.kode_produk 
AND tp.kode_cabang = mhh.kode_cabang 
AND tp.tgl_transaksi = mhh.tgl_berlaku 
JOIN ms_cabang mc ON mc.kode_cabang = mhh.kode_cabang 

 
),


m2 AS (
SELECT
	
	c.`kode_cabang`,
 	c.`nama_cabang`,k.`nama_kota`
 	
FROM `ms_cabang` AS c
JOIN   `ms_kota` as k on  k.`kode_kota` = c.`kode_kota`

),

m3 AS(

SELECT
	
	m1.nama_cabang,
	m2.nama_kota,
	YEAR(m1.tgl_transaksi) AS tahun,
	MONTH(m1.tgl_transaksi) AS bulan,
	SUM((m1.harga_berlaku_cabang - m1.modal_cabang - m1.biaya_cabang) * m1.jumlah_pembelian) AS total_profit

FROM m1	
JOIN m2 ON m2.`kode_cabang` = m1.kode_cabang
GROUP BY 2,4



)


SELECT
	RANK() OVER (PARTITION BY m3.nama_cabang,m3.bulan ORDER BY m3.total_profit ) AS top3,
	m3.nama_cabang,
	m3.nama_kota,
	m3.tahun,
	m3.bulan,
	m3.total_profit


FROM m3

;


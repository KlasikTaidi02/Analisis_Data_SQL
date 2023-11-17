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

m4 AS (
SELECT 
	k.kode_kota,
	k.`nama_kota`,
	p.`nama_propinsi`
	
FROM  ms_kota AS k
JOIN `ms_propinsi` AS p ON p.`kode_propinsi` = k.`kode_propinsi`


),


m2 AS (
SELECT
	
	c.`kode_cabang`,
 	c.`nama_cabang`,m4.`nama_kota`,
 	m4.`nama_propinsi`
 	
FROM `ms_cabang` AS c
JOIN m4   ON m4.kode_kota = c.kode_kota

),

m3 AS(

SELECT
	
	m1.nama_cabang,
	m2.nama_kota,
	m2.`nama_propinsi`,
	m1.kode_cabang
	 ,YEAR(m1.tgl_transaksi) AS tahun,
  	MONTH(m1.tgl_transaksi) AS bulan,
	SUM((m1.harga_berlaku_cabang - m1.modal_cabang - m1.biaya_cabang) * m1.jumlah_pembelian) AS total_profit

FROM m1	
JOIN m2 ON m2.`kode_cabang` = m1.kode_cabang
  GROUP BY 3,6



)

SELECT

	RANK() OVER (PARTITION BY m3.nama_cabang,m3.bulan ORDER BY m3.total_profit ) AS top3,
	m3.nama_cabang,
	m3.nama_propinsi,
	m3.tahun,
	m3.bulan
	,m3.total_profit


FROM m3;



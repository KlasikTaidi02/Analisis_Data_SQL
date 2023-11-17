
WITH m1 AS (
SELECT 
nama_cabang,tp.kode_cabang,
tp.tgl_transaksi,
mhh.harga_berlaku_cabang,mhh.modal_cabang ,mhh.biaya_cabang, tp.jumlah_pembelian,
p.`nama_produk`

FROM tr_penjualan tp 
JOIN ms_harga_harian mhh ON tp.kode_produk = mhh.kode_produk 
AND tp.kode_cabang = mhh.kode_cabang 
AND tp.tgl_transaksi = mhh.tgl_berlaku 
JOIN ms_cabang mc ON mc.kode_cabang = mhh.kode_cabang 
JOIN `ms_produk` AS p ON p.`kode_produk` = tp.`kode_produk`
 
),


m2 AS (
SELECT
	
	c.`kode_cabang`,
 	c.`nama_cabang`,k.`nama_kota`
 	
FROM `ms_cabang` AS c
JOIN   `ms_kota` AS k ON  k.`kode_kota` = c.`kode_kota`

),

m3 AS(

SELECT
	m1.`nama_produk`,
	m1.nama_cabang,
	m2.nama_kota,
	YEAR(m1.tgl_transaksi) AS tahun,
	MONTH(m1.tgl_transaksi) AS bulan,
	SUM((m1.harga_berlaku_cabang - m1.modal_cabang - m1.biaya_cabang) * m1.jumlah_pembelian) AS total_profit

FROM m1	
JOIN m2 ON m2.`kode_cabang` = m1.kode_cabang
GROUP BY 3,1,4



),

m4 AS(

SELECT
	m3.nama_produk,
	
	m3.nama_kota,
	m3.tahun,
	m3.bulan,
	m3.total_profit
	,LAG(total_profit) OVER(PARTITION BY nama_kota  ORDER BY m3.bulan ) AS prev_month
	
FROM m3

),

m5 AS(

SELECT  
	nama_produk,
	nama_kota,
	tahun,
	bulan,
	total_profit,
	prev_month,
	CASE
	     WHEN prev_month  IS NULL THEN  NULL
	     ELSE total_profit - prev_month
	
	END AS selisih
	
	

FROM m4


),

m6 AS(

SELECT *,
	CASE
	     WHEN prev_month  IS NULL THEN  NULL
	     ELSE selisih/prev_month
	
	END AS persentase

FROM m5
)

SELECT *,
	CASE
	     WHEN prev_month  IS NULL THEN  NULL
	     ELSE  CONCAT (CAST(ROUND((persentase*100),2) AS CHAR)," %")
	
	END AS persentasetext
FROM m6
;













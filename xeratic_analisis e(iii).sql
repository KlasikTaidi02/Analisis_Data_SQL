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
	
	MONTH(m1.tgl_transaksi) AS bulan,
	SUM((m1.harga_berlaku_cabang - m1.modal_cabang - m1.biaya_cabang) * m1.jumlah_pembelian) AS total_profit
	
FROM m1	
JOIN m2 ON m2.`kode_cabang` = m1.kode_cabang
GROUP BY 3,1,4



),

final AS(

SELECT
	*,
	RANK() OVER (PARTITION BY bulan ,nama_kota ORDER BY m3.total_profit DESC  ) AS top3
	
FROM m3



)


SELECT RANK() OVER(PARTITION BY f.nama_kota,f.bulan  ORDER BY f.total_profit DESC  ) AS top3,
	f.nama_produk,
	f.nama_kota,
	bulan,
	total_profit
	
FROM  final AS f

WHERE f.top3 < 4

;





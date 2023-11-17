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
	m1.`nama_produk`,
	m1.nama_cabang,
	m2.nama_kota,
	m2.`nama_propinsi`,
	m1.kode_cabang,
	 
  	MONTH(m1.tgl_transaksi) AS bulan,
	SUM((m1.harga_berlaku_cabang - m1.modal_cabang - m1.biaya_cabang) * m1.jumlah_pembelian) AS total_profit

FROM m1	
JOIN m2 ON m2.`kode_cabang` = m1.kode_cabang
 GROUP BY 4,1,6



),

 final AS(

SELECT
	*,
	RANK() OVER (PARTITION BY m3.bulan,m3.nama_propinsi ORDER BY m3.total_profit DESC ) AS top3
	

FROM m3

)

SELECT 

	RANK() OVER(PARTITION BY f.nama_kota,f.bulan  ORDER BY f.total_profit DESC  ) AS top3,
	f.nama_produk,
	f.nama_propinsi,
	bulan,
	total_profit
	
FROM  final AS f

WHERE f.top3 < 4



;



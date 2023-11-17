
WITH summaryT AS(

	SELECT *
	
	FROM `timbunan2022` AS t22

	WHERE t22.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `timbunan2022` AS t22

	INNER JOIN `timbunan2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `timbunan2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `timbunan2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

	UNION

	SELECT *
	 
	FROM `timbunan2021` AS t21

	WHERE t21.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `timbunan2022` AS t22

	INNER JOIN `timbunan2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `timbunan2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `timbunan2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

	UNION

	SELECT *
	 
	FROM `timbunan2020` AS t20

	WHERE t20.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `timbunan2022` AS t22

	INNER JOIN `timbunan2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `timbunan2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `timbunan2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

	UNION

	SELECT *
	 
	FROM `timbunan2019` AS t19

	WHERE t19.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `timbunan2022` AS t22

	INNER JOIN `timbunan2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `timbunan2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `timbunan2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)



)

,


SummaryJ AS(

	SELECT *
	 
	FROM `jenissampah2022` AS t22

	WHERE t22.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `jenissampah2022` AS t22

	INNER JOIN `jenissampah2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `jenissampah2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `jenissampah2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`
	
		
	)
		
	UNION

	SELECT *
	 
	FROM `jenissampah2021` AS t21

	WHERE t21.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `jenissampah2022` AS t22

	INNER JOIN `jenissampah2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `jenissampah2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `jenissampah2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

	UNION

	SELECT *
	 
	FROM `jenissampah2020` AS t20

	WHERE t20.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `jenissampah2022` AS t22

	INNER JOIN `jenissampah2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `jenissampah2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `jenissampah2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

	UNION

	SELECT *
	 
	FROM `jenissampah2019` AS t21

	WHERE t21.`Kabupaten/Kota` IN(

	SELECT 
		t22.`Kabupaten/Kota`
		
	FROM `jenissampah2022` AS t22

	INNER JOIN `jenissampah2021` AS t21 ON t22.`Kabupaten/Kota` = t21.`Kabupaten/Kota` 
	INNER JOIN `jenissampah2020` AS t20 ON t22.`Kabupaten/Kota` = t20.`Kabupaten/Kota`
	INNER JOIN `jenissampah2019` AS  t19 ON t22.`Kabupaten/Kota` = t19.`Kabupaten/Kota`

	)

)



-- select s.Tahun, s.Provinsi,
-- 	
-- 	avg(`Timbulan Sampah Harian(ton)`) as `Rata- Rata Timbulan Sampah Harian(ton)`, 
-- 	sum(`Timbulan Sampah Tahunan(ton)`) as `Timbulan Sampah Tahunan(ton)`
-- 
-- from SummaryT as s
-- group by s.Tahun, s.Provinsi
-- 
-- ;

SELECT s.Tahun, s.Provinsi,
	ROUND(AVG(s.`Timbulan Sampah Harian(ton)`),2) AS `Rata- Rata Timbulan Sampah Harian(ton)`, 
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`),2) AS `Timbulan Sampah Tahunan(ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*j.`Sisa Makanan (%)`/100),2) AS `Sisa Makanan (ton)`,
	ROUND(SUM(s.`Timbulan Sampah Tahunan(ton)`*`Kayu-Ranting (%)`/100),2) AS `Kayu-Ranting (ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*`Kertas-Karton (%)`/100),2) AS `Kertas-Karton (ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*`Plastik(%)`/100),2) AS `Plastik(ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*`Logam(%)`/100),2) AS `Logam(ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*`Kain(%)`/100),2) AS `Kain(ton)`,
	ROUND(SUM(s.`Timbulan Sampah Tahunan(ton)`*`Karet- Kulit (%)`/100),2) AS `Karet- Kulit (ton)`,
	ROUND(SUM(s.`Timbulan Sampah Tahunan(ton)`*`Kaca(%)`/100),2) AS `Karet- Kulit (ton)`,
	ROUND (SUM(s.`Timbulan Sampah Tahunan(ton)`*`Lainnya(%)`/100),2) AS `Lainnya(ton)`
	

FROM SummaryT AS s
INNER JOIN SummaryJ AS j ON s.`Kabupaten/Kota`  = j.`Kabupaten/Kota`
where s.Tahun = "2021"
GROUP BY s.Tahun, s.Provinsi;


SELECT mp.cod_metodo, mp.tipo_metodo, COUNT(v.cod_metodo) AS cantidad_usos, SUM(v.precio_total) AS importe_recaudado
FROM Metodo_pago AS mp 
INNER JOIN venta AS v
ON mp.cod_metodo = v.cod_metodo
GROUP BY  mp.cod_metodo, mp.tipo_metodo
ORDER BY cantidad_usos DESC


SELECT 
    o.cod_oferta,
    o.detalle_oferta,
    c.cod_cliente,
    c.nombre_cliente,
    c.apellido_cliente,
    n.estado_notificacion
FROM Notificacion n
JOIN Cliente c ON n.cod_cliente = c.cod_cliente
JOIN Oferta o ON n.cod_oferta = o.cod_oferta
WHERE n.estado_notificacion = 'ENVIADA'
  AND o.fecha_finalizacion >= GETDATE();
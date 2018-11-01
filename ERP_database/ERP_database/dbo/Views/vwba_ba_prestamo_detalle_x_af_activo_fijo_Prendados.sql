

create view vwba_ba_prestamo_detalle_x_af_activo_fijo_Prendados as
SELECT        dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdEmpresa, dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdPrestamo, 
                         dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdActivoFijo, dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.Garantia_Bancaria, 
                         dbo.Af_Activo_fijo.Af_costo_compra
FROM            dbo.Af_Activo_fijo INNER JOIN
                         dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados ON dbo.Af_Activo_fijo.IdEmpresa = dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdEmpresa AND 
                         dbo.Af_Activo_fijo.IdActivoFijo = dbo.ba_prestamo_detalle_x_af_activo_fijo_Prendados.IdActivoFijo
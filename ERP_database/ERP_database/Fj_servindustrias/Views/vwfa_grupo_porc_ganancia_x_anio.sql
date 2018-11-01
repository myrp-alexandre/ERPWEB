CREATE VIEW [Fj_servindustrias].[vwfa_grupo_porc_ganancia_x_anio]
AS
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.porcentaje, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdAnio, Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo, Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC, 'X_ACTIVO' AS TIPO, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo, 
				  cast( cast(year(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) as varchar(4)) + RIGHT(replicate('0',2)+ cast(month(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) as varchar(2)),2) as int) IdPeriodo_ini, 
				  cast( cast(year(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) as varchar(4)) + RIGHT(replicate('0',2)+ cast(month(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) as varchar(2)),2) as int) IdPeriodo_fin
                  
FROM     Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo ON 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario INNER JOIN
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo_det ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto_sub_centro_costo INNER JOIN
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo ON Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdGrupo INNER JOIN
                  Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdActivoFijo_AF
WHERE  (Fj_servindustrias.fa_tarifario_facturacion_x_cliente.Estado = 1) AND (Fj_servindustrias.fa_grupo_x_sub_centro_costo.Estado = 1)
GROUP BY Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.porcentaje, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdAnio, Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo, Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdActivoFijo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin
UNION ALL
SELECT Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.porcentaje, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdAnio, Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo, NULL AS IdPuntoCargo, 'X_SUBCENTRO' AS TIPO, isnull(cast(0 AS int), 0), 
				  cast( cast(year(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) as varchar(4)) + RIGHT(replicate('0',2)+ cast(month(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) as varchar(2)),2) as int) IdPeriodo_ini, 
				  cast( cast(year(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) as varchar(4)) + RIGHT(replicate('0',2)+ cast(month(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) as varchar(2)),2) as int) IdPeriodo_fin
FROM     Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo ON 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario INNER JOIN
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo_det ON Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto AND 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdCentroCosto_sub_centro_costo INNER JOIN
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo ON Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdEmpresa = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo = Fj_servindustrias.fa_grupo_x_sub_centro_costo.IdGrupo
WHERE  (Fj_servindustrias.fa_tarifario_facturacion_x_cliente.Estado = 1) AND (Fj_servindustrias.fa_grupo_x_sub_centro_costo.Estado = 1)
GROUP BY Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdEmpresa, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo.IdCentroCosto_sub_centro_costo, Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.porcentaje, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdAnio, Fj_servindustrias.fa_grupo_x_sub_centro_costo_det.IdGrupo,Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio, 
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin
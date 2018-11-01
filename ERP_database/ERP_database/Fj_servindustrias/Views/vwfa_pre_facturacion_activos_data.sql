CREATE VIEW [Fj_servindustrias].[vwfa_pre_facturacion_activos_data]
AS
SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY tarifario_activos.IdEmpresa), 0) IdRow, tarifario_activos.IdEmpresa, tarifario_activos.IdCentroCosto, tarifario_activos.IdCentroCosto_sub_centro_costo, tarifario_activos.IdActivoFijo, grupo.IdGrupo, ISNULL(af_x_scc.cant_af_x_scc, 0) AS cant_af_x_scc, 
                  ISNULL(CAST(CAST(YEAR(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) AS varchar(4)) + RIGHT(REPLICATE('0', 2) 
                  + CAST(MONTH(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_inicio) AS varchar(2)), 2) AS int), 0) AS IdPeriodo_ini, 
                  ISNULL(CAST(CAST(YEAR(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) AS varchar(4)) + RIGHT(REPLICATE('0', 2) 
                  + CAST(MONTH(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.Fecha_Fin) AS varchar(2)), 2) AS int), 0) AS IdPeriodo_fin, ISNULL(Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.porcentaje, 0) 
                  AS porcentaje, dbo.ct_centro_costo_sub_centro_costo.Valor_depreciacion, Fj_servindustrias.fa_tarifario_facturacion_x_cliente.valor_minimo_movilizacion
FROM     Fj_servindustrias.fa_grupo_x_sub_centro_costo AS grupo INNER JOIN
                  Fj_servindustrias.fa_grupo_x_sub_centro_costo_det AS grupo_det ON grupo.IdEmpresa = grupo_det.IdEmpresa AND grupo.IdGrupo = grupo_det.IdGrupo INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo AS tarifario_activos ON grupo_det.IdEmpresa = tarifario_activos.IdEmpresa AND 
                  grupo_det.IdCentroCosto_sub_centro_costo = tarifario_activos.IdCentroCosto_sub_centro_costo AND grupo_det.IdCentroCosto = tarifario_activos.IdCentroCosto INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision ON tarifario_activos.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdEmpresa AND 
                  tarifario_activos.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision.IdTarifario INNER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON grupo_det.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND grupo_det.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  grupo_det.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo INNER JOIN
                  Fj_servindustrias.fa_tarifario_facturacion_x_cliente ON tarifario_activos.IdEmpresa = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdEmpresa AND 
                  tarifario_activos.IdTarifario = Fj_servindustrias.fa_tarifario_facturacion_x_cliente.IdTarifario LEFT OUTER JOIN
                      (SELECT IdEmpresa, IdCentroCosto, IdCentroCosto_sub_centro_costo, COUNT(IdTarifario) AS cant_af_x_scc
                       FROM      Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo AS ac
                       GROUP BY IdEmpresa, IdCentroCosto, IdCentroCosto_sub_centro_costo) AS af_x_scc ON af_x_scc.IdEmpresa = tarifario_activos.IdEmpresa AND tarifario_activos.IdCentroCosto = af_x_scc.IdCentroCosto AND 
                  tarifario_activos.IdCentroCosto_sub_centro_costo = af_x_scc.IdCentroCosto_sub_centro_costo
CREATE VIEW [Fj_servindustrias].[vwfa_registro_unidades_x_equipo_para_facturacion]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY c.IdEmpresa), 0) AS IdRow, c.IdEmpresa, c.IdRegistro, b.IdActivoFijo, b.Af_ValorUnidad_Actu, c.IdPeriodo, b.IdEmpresa_hn, b.IdSucursal_hn, b.IdBodega_hn, b.IdCbteVta_hn, isnull(det.unidades_maximas, 0) 
unidades_maximas, isnull(CASE WHEN isnull(det.unidades_maximas, 0) <> 0 THEN round(isnull(det.unidades_maximas, 0) - b.Af_ValorUnidad_Actu, 2) ELSE 0 END, 0) AS diferencia_a_facturar, ct_punto_cargo.IdPunto_cargo, 
ct_punto_cargo.nom_punto_cargo, c.IdCentroCosto, c.IdCentroCosto_sub_centro_costo, ct_punto_cargo.IdPunto_cargo_grupo, b.IdEmpresa_he, b.IdSucursal_he, b.IdBodega_he, b.IdCbteVta_he
FROM     (SELECT IdEmpresa, IdRegistro, IdActivoFijo, MAX(Valor) AS unidades_maximas
                  FROM      Fj_servindustrias.fa_registro_unidades_x_equipo_det
                  GROUP BY IdEmpresa, IdRegistro, IdActivoFijo) AS det RIGHT OUTER JOIN
                  Fj_servindustrias.fa_registro_unidades_x_equipo AS c INNER JOIN
                  Fj_servindustrias.fa_registro_unidades_x_equipo_det_ini_x_Af AS b ON c.IdEmpresa = b.IdEmpresa AND c.IdRegistro = b.IdRegistro INNER JOIN
                  Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo INNER JOIN
                  ct_punto_cargo ON Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_PC = ct_punto_cargo.IdEmpresa AND Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC = ct_punto_cargo.IdPunto_cargo ON 
                  b.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF AND b.IdActivoFijo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdActivoFijo_AF ON det.IdEmpresa = b.IdEmpresa AND 
                  det.IdRegistro = b.IdRegistro AND det.IdActivoFijo = b.IdActivoFijo
WHERE  (c.Estado = 'A') AND c.estado_cierre = 1
CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt010]
AS
SELECT isnull(ROW_NUMBER() over(order by Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa),0) as IdRow, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdRegistro, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdActivoFijo, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdPeriodo, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCbteVta_hn, fac_hn.vt_NumFactura AS vt_NumFactura_hn, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.Af_ValorUnidad_Actu, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.unidades_maximas, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.diferencia_a_facturar, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdPunto_cargo, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.nom_punto_cargo, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCentroCosto, Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCentroCosto_sub_centro_costo, 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCbteVta_he, fac_he.vt_NumFactura AS vt_NumFactura_he, ct_centro_costo.Centro_costo AS nom_Centro_costo, 
                  ct_centro_costo_sub_centro_costo.Centro_costo AS nom_Centro_costo_sub_centro_costo, vwct_periodo.smes +' '+ cast(vwct_periodo.IdanioFiscal as varchar(20)) as nom_periodo
FROM     fa_factura AS fac_hn RIGHT OUTER JOIN
                  vwct_periodo INNER JOIN
                  ct_centro_costo_sub_centro_costo INNER JOIN
                  ct_centro_costo ON ct_centro_costo_sub_centro_costo.IdEmpresa = ct_centro_costo.IdEmpresa AND ct_centro_costo_sub_centro_costo.IdCentroCosto = ct_centro_costo.IdCentroCosto INNER JOIN
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion ON 
                  ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCentroCosto_sub_centro_costo AND 
                  ct_centro_costo_sub_centro_costo.IdCentroCosto = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCentroCosto AND 
                  ct_centro_costo_sub_centro_costo.IdEmpresa = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa ON 
                  vwct_periodo.IdEmpresa = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa AND vwct_periodo.IdPeriodo = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdPeriodo ON 
                  fac_hn.IdEmpresa = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa_hn AND fac_hn.IdSucursal = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdSucursal_hn AND 
                  fac_hn.IdBodega = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdBodega_hn AND fac_hn.IdCbteVta = Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCbteVta_hn LEFT OUTER JOIN
                  fa_factura AS fac_he ON Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdEmpresa_he = fac_he.IdEmpresa AND 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdSucursal_he = fac_he.IdSucursal AND Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdBodega_he = fac_he.IdBodega AND 
                  Fj_servindustrias.vwfa_registro_unidades_x_equipo_para_facturacion.IdCbteVta_he = fac_he.IdCbteVta
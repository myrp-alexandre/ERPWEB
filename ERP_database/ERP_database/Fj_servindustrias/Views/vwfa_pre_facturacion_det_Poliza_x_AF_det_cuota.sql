CREATE VIEW [Fj_servindustrias].[vwfa_pre_facturacion_det_Poliza_x_AF_det_cuota]
AS
SELECT d.IdEmpresa, d.IdPoliza, d.cod_couta, CAST(CAST(YEAR(d.Fecha_Pago) AS varchar(4)) + RIGHT('00' + CAST(MONTH(d.Fecha_Pago) AS varchar(2)), 2) AS int) AS IdPeriodo, c.IdCentroCosto, c.IdCentroCosto_sub_centro_costo, 
                  d.valor_prima, d.IdEstadoFacturacion_cat
FROM     Fj_servindustrias.Af_Poliza_x_AF_det_cuota AS d INNER JOIN
                  Fj_servindustrias.Af_Poliza_x_AF AS c ON c.IdEmpresa = d.IdEmpresa AND c.IdPoliza = d.IdPoliza
WHERE  (c.Estado = 'A')
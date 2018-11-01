CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt015]
AS
SELECT isnull(ROW_NUMBER() OVER (ORDER BY Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa), 0) AS IdRow, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdPunto_cargo, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_fecha, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdTerminoPago, Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto_sub_centro_costo, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_num_orden, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_num_horas, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_atencion_a, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdBodega, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_tipo_pedido, Fj_servindustrias.fa_liquidacion_x_punto_cargo.estado, dbo.tb_persona.pe_nombreCompleto, 
dbo.tb_persona.pe_cedulaRuc, dbo.fa_TerminoPago.nom_TerminoPago, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_centro_costo_sub_centro_costo.Centro_costo, dbo.tb_sucursal.codigo, dbo.tb_sucursal.Su_Descripcion, 
'Pre-Factura Numero: ' + dbo.tb_sucursal.codigo + ' ' + CAST(Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdLiquidacion AS varchar(20)) AS cod_liquidacion, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_reporte_mantenimiento, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_subtotal, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_por_iva, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_valor_iva, Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_total, 
Fj_servindustrias.fa_liquidacion_x_punto_cargo.li_observacion, tb_sucursal.Su_Direccion
FROM     dbo.fa_TerminoPago INNER JOIN
                  Fj_servindustrias.fa_cliente_x_ct_centro_costo INNER JOIN
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo ON Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cc = Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa AND 
                  Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCentroCosto_cc = Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto INNER JOIN
                  dbo.fa_cliente ON Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdEmpresa_cli = dbo.fa_cliente.IdEmpresa AND Fj_servindustrias.fa_cliente_x_ct_centro_costo.IdCliente_cli = dbo.fa_cliente.IdCliente INNER JOIN
                  dbo.tb_persona ON dbo.fa_cliente.IdPersona = dbo.tb_persona.IdPersona ON dbo.fa_TerminoPago.IdTerminoPago = Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdTerminoPago INNER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo INNER JOIN
                  dbo.tb_sucursal ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.tb_sucursal.IdEmpresa AND Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdSucursal = dbo.tb_sucursal.IdSucursal LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.fa_liquidacion_x_punto_cargo.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
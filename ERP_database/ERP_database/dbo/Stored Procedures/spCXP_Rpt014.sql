-- ================================================
 
CREATE PROCEDURE [dbo].[spCXP_Rpt014]	 
	@idempresa int,
	  @fecha date ,
	  @idProveedorIni decimal ,
	  @idProveedorFIn decimal 
AS
BEGIN
	 
Select					IdEmpresa, IdProveedor, nom_proveedor, SUM(Valor_a_pagar)Valor_a_pagar,   Sum(MontoAplicado)MontoAplicado, sum(Saldo)Saldo,  Ruc_Proveedor ,  Tipo_cbte,  
                        sum(Ven_1_30)Ven_1_30, 			 sum(Ven_31_60)Ven_31_60,						    sum(Ven_61_180)Ven_61_180,						  sum(Ven_180_9999)Ven_180_9999
						,  sum(x_Ven_1_30)x_Ven_1_30, 						 sum(x_Ven_31_60)x_Ven_31_60,						 sum(x_Ven_61_180)x_Ven_61_180,						 sum(x_Ven_180_9999 )x_Ven_180_9999 
							from ( 
							Select A.IdEmpresa, A.IdCbteCble_Ogiro, A.IdTipoCbte_Ogiro, A.IdOrden_giro_Tipo, A.Documento, A.nom_tipo_doc, A.cod_tipo_doc, A.co_fechaOg, 
                         A.IdProveedor, A.nom_proveedor, A.Valor_a_pagar, ISNULL(b.MontoAplicado, 0) AS MontoAplicado, A.Saldo, A.Observacion, A.Ruc_Proveedor, A.representante_legal, A.Tipo_cbte, A.Plazo, 
                         b.cb_Fecha, 
						 (Case when datediff(day,cb_Fecha,@fecha) <=30 then Saldo else 0 end) Ven_1_30, 
						 (Case when datediff(day,cb_Fecha,@fecha) >=30  and datediff(day,cb_Fecha,@fecha) <=60 then Saldo else 0 end) Ven_31_60,
						 (Case when datediff(day,cb_Fecha,@fecha) >=90  and datediff(day,cb_Fecha,@fecha) >=180 then Saldo else 0 end) Ven_61_180,
						 (Case when datediff(day,cb_Fecha,@fecha) >=180  and datediff(day,cb_Fecha,@fecha) >=9999 then Saldo else 0 end) Ven_180_9999

					 ,  (Case when datediff(day,cb_Fecha,@fecha) >=30 then Saldo else 0 end) x_Ven_1_30, 
						 (Case when datediff(day,cb_Fecha,@fecha) <=30  and datediff(day,cb_Fecha,@fecha) >=60 then Saldo else 0 end) x_Ven_31_60,
						 (Case when datediff(day,cb_Fecha,@fecha) <=90  and datediff(day,cb_Fecha,@fecha) >=180 then Saldo else 0 end) x_Ven_61_180,
						 (Case when datediff(day,cb_Fecha,@fecha) <=180  and datediff(day,cb_Fecha,@fecha) >=9999 then Saldo else 0 end) x_Ven_180_9999

						  from (Select * from (SELECT      a.co_FechaFactura_vct,           a.IdEmpresa, a.IdCbteCble_Ogiro, a.IdTipoCbte_Ogiro, a.IdOrden_giro_Tipo, b.Codigo + '#:' + CAST(a.IdCbteCble_Ogiro AS VARCHAR(20)) 
                         + '/' + a.co_serie + '-' + a.co_factura AS Documento, b.Descripcion AS nom_tipo_doc, b.Codigo AS cod_tipo_doc, a.co_fechaOg, c.IdProveedor, 
                         d.pe_nombreCompleto AS nom_proveedor, a.co_valorpagar AS Valor_a_pagar, ROUND(a.SaldoOG, 2) AS Saldo, 
                         a.co_observacion AS Observacion, d.pe_cedulaRuc AS Ruc_Proveedor, c.representante_legal, 'CBTE_CXP' AS Tipo_cbte,   
						 DATEDIFF(day, co_FechaFactura, co_FechaFactura_vct) as Plazo
FROM            dbo.vwcp_orden_giro_total_saldo AS a INNER JOIN
                         dbo.cp_TipoDocumento AS b ON a.IdOrden_giro_Tipo = b.CodTipoDocumento INNER JOIN
                         dbo.cp_proveedor AS c ON a.IdEmpresa = c.IdEmpresa AND a.IdProveedor = c.IdProveedor INNER JOIN
                         dbo.tb_persona AS d ON c.IdPersona = d.IdPersona) as a
						 where IdEmpresa = @idempresa and IdProveedor between @idProveedorIni and @idProveedorFIn) as A
 left join (
 Select IdEmpresa,IdEmpresa_cxp,IdTipoCbte_cxp ,IdCbteCble_cxp,sum(MontoAplicado)MontoAplicado , Max(cb_Fecha ) cb_Fecha from 
 (SELECT a.IdEmpresa,IdEmpresa_cxp,IdTipoCbte_cxp ,b.IdCbteCble_cxp,b.MontoAplicado,b.IdEmpresa_pago,IdTipoCbte_pago,b.IdCbteCble_pago, A.cb_Fecha FROM ct_cbtecble A 
 INNER JOIN (SELECT IdEmpresa, IdEmpresa_cxp,IdTipoCbte_cxp,IdCbteCble_cxp,Sum(MontoAplicado)MontoAplicado,cast(fechaTransaccion as date) 
 fechaTransaccion,IdEmpresa_pago,IdTipoCbte_pago,IdCbteCble_pago 
 from cp_orden_pago_cancelaciones  group by IdEmpresa, IdEmpresa_cxp,IdTipoCbte_cxp,IdCbteCble_cxp, cast(fechaTransaccion as date) 
  ,IdEmpresa_pago,IdTipoCbte_pago,IdCbteCble_pago having IdEmpresa =@idempresa) AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdTipoCbte = B.IdTipoCbte_pago 
  AND A.IdCbteCble = B.IdCbteCble_pago 
  where   A.cb_Estado = 'A'
 
and cb_Fecha<= @fecha
 
) as VISTA 
group by IdEmpresa,IdEmpresa_cxp,IdTipoCbte_cxp ,IdCbteCble_cxp ) as 
b on
 a.IdEmpresa = b.IdEmpresa_cxp and a.IdCbteCble_Ogiro = b.IdCbteCble_cxp and a.IdTipoCbte_Ogiro = b.IdTipoCbte_cxp and  a.IdEmpresa = b.IdEmpresa
 ) as result
 group by IdEmpresa, IdProveedor, nom_proveedor,      Ruc_Proveedor,  Tipo_cbte 
                   

END
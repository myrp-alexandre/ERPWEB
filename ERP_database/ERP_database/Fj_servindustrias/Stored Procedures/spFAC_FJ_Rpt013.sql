
create PROCEDURE [Fj_servindustrias].[spFAC_FJ_Rpt013] 
	@IdEmpresa int,
	@IdPeriodo int,
	@IdCentroCosto int
	
AS


BEGIN
/*
declare 
	@IdEmpresa int,
	@IdPeriodo int,
	@IdCentroCosto int

	set @IdEmpresa=1
	set @IdPeriodo=201701
	set @IdCentroCosto=007
	
	*/
declare
	@MontoAsegurado float
select @MontoAsegurado=  SUM(suma_asegurada) from Fj_servindustrias.Af_Poliza_x_AF where IdEmpresa=@IdEmpresa and IdCentroCosto=@IdCentroCosto

SELECT        Pref_Det_Pol.IdEmpresa, Pref_Det_Pol.IdPreFacturacion, Pref_Det_Pol.secuencia, Pref_Det_Pol.IdCentro_Costo, Pref_Det_Pol.IdCentroCosto_sub_centro_costo, 
                         Pref_Det_Pol.IdPunto_cargo, Pref_Det_Pol.Tipo_Cobro_Poliza_X, Pref_Det_Pol.IdEmpresa_pol_det, Pref_Det_Pol.IdPoliza_pol_det, 
                         Pref_Det_Pol.IdActivoFijo_pol_det, Pref_Det_Pol.secuencia_pol_det, Pref_Det_Pol.IdEmpresa_pol_cuota, Pref_Det_Pol.IdPoliza_pol_cuota, 
                         Pref_Det_Pol.cod_cuota_pol_cuota, Pref_Det_Pol.Cantidad, Pref_Det_Pol.Costo_Uni, Pref_Det_Pol.Subtotal, Pref_Det_Pol.Aplica_Iva, Pref_Det_Pol.Por_Iva, 
                         Pref_Det_Pol.Valor_Iva, Pref_Det_Pol.Total, Pref_Det_Pol.Facturar, Pref_Det_Pol.Subtotal_iva, Pref_Det_Pol.Subtotal_0, Pref_Det_Pol.IdTarifario, 
                         Pref_Det_Pol.Porc_ganancia, Poliza.num_cuotas, fa_prefc.IdPeriodo, Poliza.iva, Poliza.pago_contado, Poliza.subtotal_noIva, Poliza.porc_iva,@MontoAsegurado MontoAsegurado,CAST( cod_couta as varchar)+' de '+CAST( num_cuotas as varchar) Cuota, poliza_dt.valor_prima

FROM            Fj_servindustrias.fa_pre_facturacion_det_cobro_x_Poliza AS Pref_Det_Pol INNER JOIN
                         Fj_servindustrias.Af_Poliza_x_AF_det_cuota AS poliza_dt ON Pref_Det_Pol.IdEmpresa_pol_cuota = poliza_dt.IdEmpresa AND 
                         Pref_Det_Pol.IdPoliza_pol_cuota = poliza_dt.IdPoliza AND Pref_Det_Pol.cod_cuota_pol_cuota = poliza_dt.cod_couta INNER JOIN
                         Fj_servindustrias.Af_Poliza_x_AF AS Poliza ON poliza_dt.IdEmpresa = Poliza.IdEmpresa AND poliza_dt.IdPoliza = Poliza.IdPoliza INNER JOIN
                         Fj_servindustrias.fa_pre_facturacion AS fa_prefc ON Pref_Det_Pol.IdEmpresa = fa_prefc.IdEmpresa AND Pref_Det_Pol.IdPreFacturacion = fa_prefc.IdPreFacturacion
						 
						 and Poliza.IdEmpresa=@IdEmpresa
						 and Poliza.IdCentroCosto=@IdCentroCosto
						 and fa_prefc.IdPeriodo=@IdPeriodo
						
END
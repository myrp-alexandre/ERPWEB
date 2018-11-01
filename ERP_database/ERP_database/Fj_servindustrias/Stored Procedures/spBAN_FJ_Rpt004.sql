--exec [Fj_servindustrias].[spBAN_FJ_Rpt004] 2,201708,201708,1,9999,1,9999,0,1
CREATE PROCEDURE [Fj_servindustrias].[spBAN_FJ_Rpt004]
	@IdEmpresa as int,	
	@IdPeriodo_ini as int,
	@IdPeriodo_fin as int,
	@IdTipoFlujo_ini int,
	@IdTipoFlujo_fin int,
	@IdBanco_ini int,
	@IdBanco_fin int,
	@Mostrar_detallado bit,
	@Mostrar_registros_en_conciliacion bit
AS
BEGIN
--DETALLADO SOLO CONCILIADO
		SELECT        isnull(ROW_NUMBER() over(order by IdEmpresa_pago),0) as IdRow, IdEmpresa_cxp, IdTipoCbte_cxp, Tipo_cbte_cxp, IdCbteCble_cxp, IdEmpresa_pago, IdTipoCbte_pago, Tipo_cbte_pago, IdCbteCble_pago, co_observacion, cb_Fecha, 
						IdTipoFlujo, nom_tipo_flujo, RTRIM(cod_flujo) cod_flujo, Tipo, ABS(dc_Valor) dc_Valor, IdBanco, nom_banco, Tipo_movi, orden,pe_nombreCompleto
		from vwBAN_Rpt007
		where IdEmpresa_pago = @IdEmpresa 
		and IdTipoFlujo between @IdTipoFlujo_ini and @IdTipoFlujo_fin
		and IdBanco between @IdBanco_ini and @IdBanco_fin
		and CAST(CAST(YEAR(cb_Fecha) AS VARCHAR(10))+ ( right('00'+ CAST(MONTH(cb_Fecha) AS VARCHAR(2)),2) ) AS INT) BETWEEN @IdPeriodo_ini and @IdPeriodo_fin
		and @Mostrar_detallado = 1
		and @Mostrar_registros_en_conciliacion = 1
		and en_conci = 1
		UNION
--DETALLADO TODOS
		SELECT        isnull(ROW_NUMBER() over(order by IdEmpresa_pago),0) as IdRow, IdEmpresa_cxp, IdTipoCbte_cxp, Tipo_cbte_cxp, IdCbteCble_cxp, IdEmpresa_pago, IdTipoCbte_pago, Tipo_cbte_pago, IdCbteCble_pago, co_observacion, cb_Fecha, 
						IdTipoFlujo, nom_tipo_flujo, RTRIM(cod_flujo) cod_flujo, Tipo, ABS(dc_Valor) dc_Valor, IdBanco, nom_banco, Tipo_movi, orden,pe_nombreCompleto
		from vwBAN_Rpt007
		where IdEmpresa_pago = @IdEmpresa 
		and IdTipoFlujo between @IdTipoFlujo_ini and @IdTipoFlujo_fin
		and IdBanco between @IdBanco_ini and @IdBanco_fin
		and CAST(CAST(YEAR(cb_Fecha) AS VARCHAR(10))+ ( right('00'+ CAST(MONTH(cb_Fecha) AS VARCHAR(2)),2) ) AS INT) BETWEEN @IdPeriodo_ini and @IdPeriodo_fin
		and @Mostrar_detallado = 1
		and @Mostrar_registros_en_conciliacion = 0
		UNION
--RESUMIDO SOLO CONCILIADO
		SELECT    isnull(ROW_NUMBER() over(order by IdEmpresa_pago),0) as IdRow,  IdEmpresa_pago IdEmpresa_cxp, NULL IdTipoCbte_cxp, NULL Tipo_cbte_cxp, NULL IdCbteCble_cxp, NULL IdEmpresa_pago, NULL IdTipoCbte_pago, NULL Tipo_cbte_pago, NULL IdCbteCble_pago,'['+isnull(RTRIM(cod_flujo),'')+'] '+ nom_tipo_flujo co_observacion, NULL cb_Fecha, 
					IdTipoFlujo, nom_tipo_flujo, cod_flujo, Tipo, ABS(SUM(dc_Valor)) AS dc_Valor, 0 IdBanco, '' nom_banco, Tipo_movi, orden, null as pe_nombreCompleto
		from vwBAN_Rpt007
		where IdEmpresa_pago = @IdEmpresa 
		and IdTipoFlujo between @IdTipoFlujo_ini and @IdTipoFlujo_fin
		and IdBanco between @IdBanco_ini and @IdBanco_fin
		and CAST(CAST(YEAR(cb_Fecha) AS VARCHAR(10))+ ( right('00'+ CAST(MONTH(cb_Fecha) AS VARCHAR(2)),2) ) AS INT) BETWEEN @IdPeriodo_ini and @IdPeriodo_fin
		and @Mostrar_detallado = 0
		and @Mostrar_registros_en_conciliacion = 1
		and en_conci = 1
		GROUP BY IdEmpresa_pago,IdTipoFlujo, nom_tipo_flujo, cod_flujo, Tipo, Tipo_movi, orden	
		UNION
--RESUMIDO TODO
		SELECT    isnull(ROW_NUMBER() over(order by IdEmpresa_pago),0) as IdRow,  IdEmpresa_pago IdEmpresa_cxp, NULL IdTipoCbte_cxp, NULL Tipo_cbte_cxp, NULL IdCbteCble_cxp, NULL IdEmpresa_pago, NULL IdTipoCbte_pago, NULL Tipo_cbte_pago, NULL IdCbteCble_pago,'['+isnull(RTRIM(cod_flujo),'')+'] '+ nom_tipo_flujo co_observacion, NULL cb_Fecha, 
					IdTipoFlujo, nom_tipo_flujo, cod_flujo, Tipo, ABS(SUM(dc_Valor)) AS dc_Valor, 0 IdBanco, '' nom_banco, Tipo_movi, orden, null as pe_nombreCompleto
		from vwBAN_Rpt007
		where IdEmpresa_pago = @IdEmpresa 
		and IdTipoFlujo between @IdTipoFlujo_ini and @IdTipoFlujo_fin
		and IdBanco between @IdBanco_ini and @IdBanco_fin
		and CAST(CAST(YEAR(cb_Fecha) AS VARCHAR(10))+ ( right('00'+ CAST(MONTH(cb_Fecha) AS VARCHAR(2)),2) ) AS INT) BETWEEN @IdPeriodo_ini and @IdPeriodo_fin
		and @Mostrar_detallado = 0
		and @Mostrar_registros_en_conciliacion = 0		
		GROUP BY IdEmpresa_pago,IdTipoFlujo, nom_tipo_flujo, cod_flujo, Tipo, Tipo_movi, orden	
END


CREATE PROCEDURE [Fj_servindustrias].[spFAC_FJ_Rpt016] 
@IdEmpresa int,
@IdPeriodo int,
@FechaI date,
@FechaF date
AS

BEGIN
/*
declare 

@IdEmpresa int,
@IdPeriodo int,
@FechaI date,
@FechaF date

set @IdEmpresa =1
set @IdPeriodo =201709
set @FechaI='2017-09-01'
set @FechaF ='2017-09-30'
*/


declare
@Anio int
select @Anio=IdanioFiscal from ct_periodo where IdEmpresa=@IdEmpresa and IdPeriodo=@IdPeriodo

SELECT        emp.IdEmpleado, per.pe_cedulaRuc, per.pe_apellido+' '+ per.pe_nombre Empleado, af.Af_DescripcionCorta, cargo.ca_descripcion, mo.Salario, mo.HorasExtras, mo.Alimentacion, mo.TotalIngresos, mo.Total_mas_Beneficios, 
                         mo.TotalManoObra, subc.Centro_costo SubcentroCosto, cc.Centro_costo , mo.IdPeriodo, mo.IdCentroCosto, mo.IdCentroCosto_sub_centro_costo, mo.IdCargo, mo.IdActivoFijo, mo.IdPrefacturacion, ta_clie.nom_tarifario, 
                         ta_clie.codTarifario, ta_cli_mar_gana.IdAnio, ta_cli_mar_gana.Fecha_inicio, ta_cli_mar_gana.Fecha_Fin, ta_cli_mar_gana.porcentaje, mo.IdEmpresa, ta_cli_mar_gana.IdTarifario
FROM            dbo.ct_centro_costo AS cc INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo AS subc ON cc.IdEmpresa = subc.IdEmpresa AND cc.IdCentroCosto = subc.IdCentroCosto INNER JOIN
                         Fj_servindustrias.fa_pre_facturacion_mano_obra_servindustria AS mo ON subc.IdCentroCosto_sub_centro_costo = mo.IdCentroCosto_sub_centro_costo AND subc.IdCentroCosto = mo.IdCentroCosto AND 
                         subc.IdEmpresa = mo.IdEmpresa AND subc.IdCentroCosto_sub_centro_costo = mo.IdCentroCosto_sub_centro_costo AND subc.IdCentroCosto = mo.IdCentroCosto AND subc.IdEmpresa = mo.IdEmpresa LEFT OUTER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_Por_comision AS ta_cli_mar_gana INNER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo AS ta_x_cli_af INNER JOIN
                         Fj_servindustrias.fa_tarifario_facturacion_x_cliente AS ta_clie ON ta_x_cli_af.IdEmpresa = ta_clie.IdEmpresa AND ta_x_cli_af.IdTarifario = ta_clie.IdTarifario AND ta_x_cli_af.IdEmpresa = ta_clie.IdEmpresa AND 
                         ta_x_cli_af.IdTarifario = ta_clie.IdTarifario AND ta_x_cli_af.IdEmpresa = ta_clie.IdEmpresa AND ta_x_cli_af.IdTarifario = ta_clie.IdTarifario AND ta_x_cli_af.IdEmpresa = ta_clie.IdEmpresa AND 
                         ta_x_cli_af.IdTarifario = ta_clie.IdTarifario AND ta_x_cli_af.IdEmpresa = ta_clie.IdEmpresa AND ta_x_cli_af.IdTarifario = ta_clie.IdTarifario INNER JOIN
                         dbo.Af_Activo_fijo AS af ON ta_x_cli_af.IdEmpresa = af.IdEmpresa AND ta_x_cli_af.IdActivoFijo = af.IdActivoFijo ON ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario AND 
                         ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario AND ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario AND 
                         ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario AND ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario AND 
                         ta_cli_mar_gana.IdEmpresa = ta_clie.IdEmpresa AND ta_cli_mar_gana.IdTarifario = ta_clie.IdTarifario ON mo.IdEmpresa = af.IdEmpresa AND mo.IdActivoFijo = af.IdActivoFijo AND mo.IdEmpresa = af.IdEmpresa AND 
                         mo.IdActivoFijo = af.IdActivoFijo LEFT OUTER JOIN
                         dbo.ro_empleado AS emp INNER JOIN
                         dbo.ro_cargo AS cargo ON emp.IdEmpresa = cargo.IdEmpresa AND emp.IdCargo = cargo.IdCargo INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona ON mo.IdEmpresa = emp.IdEmpresa AND mo.IdEmpleado = emp.IdEmpleado AND mo.IdEmpresa = cargo.IdEmpresa AND mo.IdCargo = cargo.IdCargo
						 where mo.IdEmpresa=@IdEmpresa
						 and mo.IdPeriodo=@IdPeriodo
						 and @FechaF between ta_cli_mar_gana.fecha_inicio and ta_cli_mar_gana.Fecha_Fin
						 and @FechaI between ta_cli_mar_gana.fecha_inicio and ta_cli_mar_gana.Fecha_Fin
						 and ta_cli_mar_gana.IdAnio=@Anio


union

SELECT       1 IdEmpleado,'SUPERVISOR  MECANICO' Nombre,'SUPERVISORES'Cedula,'' Af_descripcion_corta,''ca_descripcion,0 Salario,0 HorasExtras,0 Alimentacion,0 TotalIngresos, 0 Total_mas_beneficios, (prefa.ValorFacturar/prefa.TotalEquipos)*fa_pre_activos.cant_act_x_scc TotalManoObra, cc.Centro_costo, sub_cc.Centro_costo subcentrocosto,@IdPeriodo,cc.IdCentroCosto,sub_cc.IdCentroCosto_sub_centro_costo,1 IdCargo, 0 IdActivofijo, fa_pre_activos.IdPreFacturacion,'' nom_tarifario,'' codTarifario,@IdPeriodo,@FechaI,@FechaF,fa_pre_activos.por_ganancia,fa_pre_activos.IdEmpresa,0 IdTarifario
FROM            Fj_servindustrias.fa_pre_facturacion_activos AS fa_pre_activos INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo AS sub_cc ON fa_pre_activos.IdEmpresa = sub_cc.IdEmpresa AND fa_pre_activos.IdCentroCosto = sub_cc.IdCentroCosto AND 
                         fa_pre_activos.IdCentroCosto_sub_centro_costo = sub_cc.IdCentroCosto_sub_centro_costo INNER JOIN
                         dbo.ct_centro_costo AS cc ON sub_cc.IdEmpresa = cc.IdEmpresa AND sub_cc.IdCentroCosto = cc.IdCentroCosto AND sub_cc.IdEmpresa = cc.IdEmpresa AND sub_cc.IdCentroCosto = cc.IdCentroCosto AND 
                         sub_cc.IdEmpresa = cc.IdEmpresa AND sub_cc.IdCentroCosto = cc.IdCentroCosto INNER JOIN
                         Fj_servindustrias.fa_pre_facturacion AS prefa ON fa_pre_activos.IdEmpresa = prefa.IdEmpresa AND fa_pre_activos.IdPreFacturacion = prefa.IdPreFacturacion
where IdPeriodo=@IdPeriodo
and fa_pre_activos.IdEmpresa=@IdEmpresa
GROUP BY fa_pre_activos.IdEmpresa, fa_pre_activos.IdPreFacturacion, fa_pre_activos.por_ganancia, fa_pre_activos.IdCentroCosto, fa_pre_activos.IdCentroCosto_sub_centro_costo, 
                         fa_pre_activos.IdPeriodo_fin, fa_pre_activos.cant_act_x_scc, cc.Centro_costo, sub_cc.Centro_costo, cc.IdCentroCosto, sub_cc.IdCentroCosto_sub_centro_costo, prefa.TotalEquipos, prefa.ValorFacturar



END
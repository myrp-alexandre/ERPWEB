
CREATE procedure [web].[SPROL_015]
(
@FechaInicio date,
@FechaFin date,
@IdEmpresa int)

as begin
select emp.IdEmpresa, Valores.IdEmpleado,emp.IdNominaTipo, emp.IdNominaTipoLiqui,emp.pe_cedulaRuc, emp.pe_nombreCompleto, 
sum(Valores.Decimocuarto)/3 Decimocuarto, sum(Valores.DecimoTercero)/3 DecimoTercero,sum( Valores.Vacaciones)/3Vacaciones

from
(
SELECT        r_detalle.IdEmpresa, r_detalle.IdNominaTipo, r_detalle.IdNominaTipoLiqui, r_detalle.IdPeriodo, r_detalle.IdEmpleado,
rubros.ru_descripcion, pers.pe_nombreCompleto, pers.pe_cedulaRuc, period.pe_FechaIni, period.pe_FechaFin
FROM            dbo.ro_rol_detalle_x_rubro_acumulado AS r_detalle INNER JOIN
                         dbo.ro_rol AS rol ON r_detalle.IdEmpresa = rol.IdEmpresa AND r_detalle.IdNominaTipo = rol.IdNominaTipo AND r_detalle.IdNominaTipoLiqui = rol.IdNominaTipoLiqui AND r_detalle.IdPeriodo = rol.IdPeriodo INNER JOIN
                         dbo.ro_periodo_x_ro_Nomina_TipoLiqui AS pe_x_nom ON r_detalle.IdEmpresa = pe_x_nom.IdEmpresa AND r_detalle.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND 
                         r_detalle.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND r_detalle.IdPeriodo = pe_x_nom.IdPeriodo AND rol.IdEmpresa = pe_x_nom.IdEmpresa AND rol.IdNominaTipo = pe_x_nom.IdNomina_Tipo AND 
                         rol.IdNominaTipoLiqui = pe_x_nom.IdNomina_TipoLiqui AND rol.IdPeriodo = pe_x_nom.IdPeriodo INNER JOIN
                         dbo.ro_periodo AS period ON pe_x_nom.IdEmpresa = period.IdEmpresa AND pe_x_nom.IdPeriodo = period.IdPeriodo INNER JOIN
                         dbo.ro_rubro_tipo AS rubros ON r_detalle.IdEmpresa = rubros.IdEmpresa AND r_detalle.IdRubro = rubros.IdRubro INNER JOIN
                         dbo.ro_empleado AS emp ON r_detalle.IdEmpresa = emp.IdEmpresa AND r_detalle.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS pers ON emp.IdPersona = pers.IdPersona
						 where r_detalle.IdRubro in(199,200,295)
						 and r_detalle.IdEmpresa=@IdEmpresa
						 AND emp.IdEmpresa=@IdEmpresa
						 AND r_detalle.IdEmpleado=emp.IdEmpleado
						 and period.pe_FechaIni between @FechaInicio and @FechaFin
						 and emp.em_status='EST_ACT'
						 AND emp.em_estado='A'

						 GROUP BY
						  r_detalle.IdEmpresa, r_detalle.IdNominaTipo, r_detalle.IdNominaTipoLiqui, r_detalle.IdPeriodo, r_detalle.IdEmpleado,
rubros.ru_descripcion, pers.pe_nombreCompleto, pers.pe_cedulaRuc, period.pe_FechaIni, period.pe_FechaFin
)
emp
inner join (
(
 SELECT    IdEmpresa,IdEmpleado,IdPeriodo,IdNominaTipo,IdNominaTipoLiqui, ISNULL( [199],0)DecimoTercero ,ISNULL([200],0)Decimocuarto,
 ISNULL([295],0)Vacaciones
FROM (
    SELECT        
        ro_rol_detalle_x_rubro_acumulado.IdEmpresa,ro_rol_detalle_x_rubro_acumulado.IdEmpleado,  ro_rol_detalle_x_rubro_acumulado.IdPeriodo,ro_rol_detalle_x_rubro_acumulado.IdNominaTipo,ro_rol_detalle_x_rubro_acumulado.IdNominaTipoLiqui, ro_rol_detalle_x_rubro_acumulado.IdRubro, ro_rol_detalle_x_rubro_acumulado.Valor
		FROM ro_rol_detalle_x_rubro_acumulado , ro_rubro_tipo 
		where ro_rol_detalle_x_rubro_acumulado.IdEmpresa=ro_rubro_tipo.IdEmpresa
		and ro_rol_detalle_x_rubro_acumulado.IdRubro=ro_rubro_tipo.IdRubro
		and ro_rol_detalle_x_rubro_acumulado.IdEmpresa=@IdEmpresa
		and ro_rubro_tipo.IdEmpresa=@IdEmpresa
		and ro_rol_detalle_x_rubro_acumulado.IdRubro in(199,200,295)


) as valores
PIVOT
(
   max([Valor])
    FOR [IdRubro] IN ([199],[200],[295])
)AS pvt)
)
 Valores
 on emp.IdEmpresa=Valores.IdEmpresa
 and emp.IdEmpleado=Valores.IdEmpleado
 and emp.IdNominaTipo=Valores.IdNominaTipo
 and emp.IdNominaTipoLiqui=Valores.IdNominaTipoLiqui
 and emp.IdPeriodo=Valores.IdPeriodo


 group by
  emp.IdEmpresa, Valores.IdEmpleado,emp.IdNominaTipo, emp.IdNominaTipoLiqui,emp.pe_cedulaRuc, emp.pe_nombreCompleto

  end 
  
--exec [web].[SPROL_022]  1,1,2,201901
CREATE  PROCEDURE [web].[SPROL_022]  
	@idempresa int,
	@idnomina_tipo int,
	@idnomina_Tipo_liq int,
	@idperiodo int
	
AS

BEGIN

--declare
--    @idempresa int,
--	@idnomina_tipo int,
--	@idnomina_Tipo_liq int,
--	@idperiodo int


--set @idempresa =1
--set @idnomina_tipo =1
--set @idnomina_Tipo_liq =2
--set @idperiodo =201901

declare 
@FechaInicio date,
@FechaFin date,
@IdRubroMatutino varchar(50),
@IdRubroVespertino varchar(50),
@IdRubroTotalPagar varchar(50)

delete web.ro_SPROL_022 where IdEmpresa=@idempresa and IdPeriodo=@idperiodo
select @IdRubroMatutino=IdRubro_horas_matutina, @IdRubroVespertino=IdRubro_horas_vespertina, @IdRubroTotalPagar = IdRubro_tot_pagar from ro_rubros_calculados where IdEmpresa=@idempresa 

select @FechaInicio=pe_FechaIni, @FechaFin=pe_FechaFin from ro_periodo where IdEmpresa=IdEmpresa and IdPeriodo=@idperiodo
insert into web.ro_SPROL_022
SELECT        nov_det.IdEmpresa, emp.IdDivision, nov.IdSucursal, nov.IdNomina_TipoLiqui, emp.IdArea, nov.IdEmpleado,  nov.IdJornada,nov.IdNomina_Tipo,hor.IdPeriodo,
case when  jor.Descripcion=null then '' else jor.Descripcion+'-'+CAST( h_det.NumHoras as varchar) +'-'+CAST( h_det.ValorHora as varchar) end Descripcion, 
case when  nov.IdJornada is null then rub.ru_descripcion else 'SUELDO POR HORA' end ru_descripcion,

per.pe_apellido + ' ' + per.pe_nombre AS empleado, 
cat.ca_descripcion, rub.ru_tipo,
case when  nov.IdJornada is null then rub.ru_orden else '07' end ru_orden, 


SUM(nov_det.Valor)Valor,

 nov_det.IdRubro
FROM            dbo.ro_empleado_Novedad AS nov INNER JOIN
                         dbo.ro_empleado_novedad_det AS nov_det ON nov.IdEmpresa = nov_det.IdEmpresa AND nov.IdNovedad = nov_det.IdNovedad INNER JOIN
                         dbo.ro_empleado AS emp ON nov.IdEmpresa = emp.IdEmpresa AND nov.IdEmpresa = emp.IdEmpresa AND nov.IdEmpleado = emp.IdEmpleado AND nov.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON nov_det.IdEmpresa = rub.IdEmpresa AND nov_det.IdRubro = rub.IdRubro INNER JOIN
                         dbo.ro_HorasProfesores AS hor ON nov.IdEmpresa = hor.IdEmpresa LEFT OUTER JOIN
                         dbo.ro_HorasProfesores_det AS h_det ON nov.IdEmpresa = h_det.IdEmpresa AND nov.IdNovedad = h_det.IdNovedad AND emp.IdEmpresa = h_det.IdEmpresa AND emp.IdEmpleado = h_det.IdEmpleado AND 
                         rub.IdEmpresa = h_det.IdEmpresa AND rub.IdRubro = h_det.IdRubro AND hor.IdEmpresa = h_det.IdEmpresa AND hor.IdCarga = h_det.IdCarga LEFT OUTER JOIN
                         dbo.ro_catalogo AS cat ON rub.rub_grupo = cat.CodCatalogo LEFT OUTER JOIN
                         dbo.ro_jornada AS jor ON nov.IdEmpresa = jor.IdEmpresa AND nov.IdJornada = jor.IdJornada
WHERE        (rub.ru_tipo = 'I') 
and nov_det.FechaPago between @FechaInicio and @FechaFin
and nov.IdEmpresa=@idempresa
and nov.IdNomina_Tipo=@idnomina_tipo
and IdNomina_TipoLiqui=@idnomina_Tipo_liq
--nd per.pe_nombreCompleto like '%ACEVEDO%'
AND nov.IdJornada is not null
group by  nov_det.IdEmpresa, nov.IdEmpleado, nov.IdJornada, 
jor.Descripcion, rub.ru_descripcion,
 per.pe_apellido,
 per.pe_nombre, 
 cat.ca_descripcion, rub.ru_tipo, h_det.NumHoras, h_det.ValorHora,
 rub.ru_orden,
 emp.IdDivision,emp.IdArea,nov.IdNomina_Tipo, hor.IdPeriodo,
 nov.IdSucursal,
 nov.IdNomina_TipoLiqui,
 nov_det.idrubro

 union all 

 SELECT    r.IdEmpresa,emp.IdDivision,r_dt.IdSucursal, r.IdNominaTipoLiqui,  emp.IdArea,emp.IdEmpleado,1,r.IdNominaTipo,r.IdPeriodo, null, rub.ru_descripcion,pers.pe_apellido+' '+pers.pe_nombre, cate.ca_descripcion, rub.ru_tipo, rub.ru_orden, r_dt.Valor ,
 r_dt.IdRubro  
FROM            dbo.ro_rol AS r INNER JOIN
                         dbo.ro_rol_detalle AS r_dt ON r.IdEmpresa = r_dt.IdEmpresa AND r.IdRol = r_dt.IdRol INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON r_dt.IdEmpresa = rub.IdEmpresa AND r_dt.IdRubro = rub.IdRubro INNER JOIN
						 dbo.ro_catalogo as cate on cate.CodCatalogo = rub.rub_grupo INNER JOIN
                         dbo.ro_empleado AS emp ON r_dt.IdEmpresa = emp.IdEmpresa AND r_dt.IdEmpleado = emp.IdEmpleado INNER JOIN
                         dbo.tb_persona AS pers ON emp.IdPersona = pers.IdPersona
						 
						 WHERE  
						  r_dt.IdEmpresa=@idempresa
						 and r.IdNominaTipo=@idnomina_tipo
						 and r.IdNominaTipoLiqui=@idnomina_Tipo_liq
						 and r.IdPeriodo=@idperiodo
						 and rub.ru_tipo='I'
						 and r_dt.IdRubro not in(@IdRubroMatutino,@IdRubroVespertino)
						 and not exists
						 (
						 select * from web.ro_SPROL_022  d

						 where d.IdEmpresa=r_dt.IdEmpresa
						 and d.IdNomina_Tipo=r.IdNominaTipo
						 and d.IdNomina_TipoLiqui=r.IdNominaTipoLiqui
						 and d.IdPeriodo=r.IdPeriodo
						 and d.IdEmpleado=r_dt.IdEmpleado
						 and d.IdRubro=r_dt.IdRubro

						 and d.IdEmpresa=@idempresa
						 and d.IdNomina_Tipo=@idnomina_tipo
						 and d.IdNomina_TipoLiqui=@idnomina_Tipo_liq
						 and d.IdPeriodo=@idperiodo
						 
						 )
SELECT r.IdEmpresa, r.IdDivision, r.IdSucursal, r.IdNomina_TipoLiqui, r.IdArea, r.IdEmpleado, r.IdJornada, r.IdNomina_Tipo, r.IdPeriodo, r.Descripcion, r.ru_descripcion, r.empleado, r.ca_descripcion, r.ru_tipo, r.ru_orden, r.Valor, r.IdRubro, 
                  ro_Nomina_Tipo.Descripcion AS NomNomina, ro_Nomina_Tipoliqui.DescripcionProcesoNomina AS NomNominaTipo, tb_sucursal.Su_Descripcion, @FechaInicio AS FechaIni, @FechaFin AS FechaFin, ro_Division.Descripcion AS NomDivision, 
                  ro_area.Descripcion AS NomArea
FROM     web.ro_SPROL_022 AS r LEFT OUTER JOIN
                  ro_Division INNER JOIN
                  ro_area ON ro_Division.IdEmpresa = ro_area.IdEmpresa AND ro_Division.IdDivision = ro_area.IdDivision AND ro_Division.IdEmpresa = ro_area.IdEmpresa AND ro_Division.IdDivision = ro_area.IdDivision ON 
                  r.IdEmpresa = ro_area.IdEmpresa AND r.IdDivision = ro_area.IdDivision AND r.IdArea = ro_area.IdArea LEFT OUTER JOIN
                  tb_sucursal ON r.IdEmpresa = tb_sucursal.IdEmpresa AND r.IdSucursal = tb_sucursal.IdSucursal LEFT OUTER JOIN
                  ro_Nomina_Tipoliqui INNER JOIN
                  ro_Nomina_Tipo ON ro_Nomina_Tipoliqui.IdEmpresa = ro_Nomina_Tipo.IdEmpresa AND ro_Nomina_Tipoliqui.IdNomina_Tipo = ro_Nomina_Tipo.IdNomina_Tipo AND ro_Nomina_Tipoliqui.IdEmpresa = ro_Nomina_Tipo.IdEmpresa AND 
                  ro_Nomina_Tipoliqui.IdNomina_Tipo = ro_Nomina_Tipo.IdNomina_Tipo ON r.IdEmpresa = ro_Nomina_Tipoliqui.IdEmpresa AND r.IdNomina_TipoLiqui = ro_Nomina_Tipoliqui.IdNomina_TipoLiqui AND 
                  r.IdNomina_Tipo = ro_Nomina_Tipoliqui.IdNomina_Tipo
ORDER BY r.empleado

END
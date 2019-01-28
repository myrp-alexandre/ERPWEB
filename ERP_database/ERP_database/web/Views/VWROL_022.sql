CREATE view  web.VWROL_022 as
SELECT        nov_det.IdEmpresa, emp.IdDivision,emp.IdArea, nov.IdEmpleado,  nov.IdJornada,nov.IdNomina_Tipo,
case when  jor.Descripcion=null then '' else jor.Descripcion+'-'+CAST( h_det.NumHoras as varchar) +'-'+CAST( h_det.ValorHora as varchar) end Descripcion, 
case when  nov.IdJornada is null then rub.ru_descripcion else 'SUELDO POR HORA' end ru_descripcion,
per.pe_apellido + ' ' + per.pe_nombre AS empleado, cat.ca_descripcion, rub.ru_tipo,
rub.ru_orden, SUM(nov_det.Valor)Valor
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
--and nov.IdEmpresa=1
--and per.pe_nombreCompleto like '%ACEVEDO%'
--AND nov.IdJornada is not null
group by  nov_det.IdEmpresa, nov.IdEmpleado, nov.IdJornada, 
jor.Descripcion, rub.ru_descripcion,
 per.pe_apellido,
 per.pe_nombre, 
 cat.ca_descripcion, rub.ru_tipo, h_det.NumHoras, h_det.ValorHora,
 rub.ru_orden,
  emp.IdDivision,emp.IdArea,nov.IdNomina_Tipo
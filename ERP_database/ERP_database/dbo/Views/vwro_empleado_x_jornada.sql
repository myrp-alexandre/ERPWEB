			
		
CREATE  view vwro_empleado_x_jornada as	
select IdEmpresa,IdEmpleado,Empleado,em_status, IdNomina,IdSucursal,Pago_por_horas,SUM(Valor_horas_matutino)Valor_horas_matutino,SUM(Valor_horas_vespertina)Valor_horas_vespertina,SUM(Valor_horas_brigada)Valor_horas_brigada, SUM(Valor_hora_control_salida)Valor_hora_control_salida, SUM(Valor_hora_adicionales) Valor_hora_adicionales,
pe_cedulaRuc

from
	(	
select emp.IdSucursal, emp.IdNomina, emp.em_status, emp.Pago_por_horas,emp.Empleado, pe_cedulaRuc,jor.*
from
(
SELECT      per.pe_apellido + ' ' + per.pe_nombre AS Empleado, per.pe_cedulaRuc, emp.em_status, emp.IdEmpresa, emp.IdEmpleado, cont.IdNomina, emp.IdSucursal, emp.Pago_por_horas, emp_x_jo.IdJornada, emp_x_jo.Secuencia
FROM            dbo.ro_empleado AS emp INNER JOIN
                         dbo.tb_persona AS per ON emp.IdPersona = per.IdPersona INNER JOIN
                         dbo.ro_contrato AS cont ON emp.IdEmpresa = cont.IdEmpresa AND emp.IdEmpleado = cont.IdEmpleado INNER JOIN
                         dbo.ro_empleado_x_jornada AS emp_x_jo ON emp.IdEmpresa = emp_x_jo.IdEmpresa AND emp.IdEmpleado = emp_x_jo.IdEmpleado
)
emp
inner join (
(
 SELECT  IdEmpresa,IdEmpleado,ISNULL( [MATUTINA],0)  Valor_horas_matutino,ISNULL( [VESPERTINA],0) Valor_horas_vespertina,isnull([BRIGADA] ,0)Valor_horas_brigada,[HORA_ADICI]Valor_hora_adicionales,isnull([HORA_CONT_SAL],0)Valor_hora_control_salida, IdJornada, secuencia

FROM (
    
	select em_j.IdEmpresa, em_j.IdEmpleado, codigo, em_j.ValorHora,em_j.IdJornada,em_j.Secuencia
	FROM            dbo.ro_empleado AS emp INNER JOIN
                         dbo.ro_empleado_x_jornada AS em_j ON emp.IdEmpresa = em_j.IdEmpresa AND emp.IdEmpleado = em_j.IdEmpleado INNER JOIN
                         dbo.ro_jornada AS j ON em_j.IdEmpresa = j.IdEmpresa AND em_j.IdJornada = j.IdJornada

) as s
PIVOT
(
   max(ValorHora)
    FOR [codigo] IN ([MATUTINA],[VESPERTINA],[BRIGADA],[HORA_ADICI],[HORA_CONT_SAL])
)AS pvt)
)
 jor	on
 jor.IdEmpresa=emp.IdEmpresa
 and jor.IdEmpleado=emp.IdEmpleado
 and jor.IdJornada=emp.IdJornada
 and jor.Secuencia=emp.Secuencia
 
 )a
 group by IdEmpresa,IdSucursal,IdEmpleado, IdNomina, em_status, Pago_por_horas,Empleado,pe_cedulaRuc
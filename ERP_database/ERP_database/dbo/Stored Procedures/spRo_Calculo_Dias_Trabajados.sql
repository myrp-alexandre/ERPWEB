CREATE proc [dbo].[spRo_Calculo_Dias_Trabajados]
(@i_idempresa int
,@i_fechaIni datetime
,@i_fechaFin datetime
,@i_IdEmpleadoIni numeric
,@i_IdEmpleadoFin numeric
)
as
select IdEmpresa,   IdEmpleado,  sum(Dias_a_disfrutar) as Dias_Vaciones 
from  
(
		select IdEmpresa,   IdEmpleado,  sum(Dias_a_disfrutar) as Dias_a_disfrutar
		from (
			SELECT      IdEmpresa,   IdEmpleado,  Dias_a_disfrutar
			FROM         ro_Solicitud_Vacaciones
			where IdEmpresa=@i_idempresa 
			and Fecha_Desde between @i_fechaIni  and @i_fechaFin
			and idestadoAprobacion='APROBADO'
			and idempleado between @i_IdEmpleadoIni and @i_IdEmpleadoFin
		)  A
		group by    A.IdEmpresa,   A.IdEmpleado
		/*
		union
		
		SELECT IdEmpresa,IdEmpleado , cast((sum(TiempoAusencia)/8) as int) as TiempoAusencia
		FROM (
			SELECT IdEmpresa,IdEmpleado ,TiempoAusencia
			FROM ro_permiso_x_empleado 
			WHERE IdEmpresa =@i_idempresa 
			and Fecha between @i_fechaIni  and @i_fechaFin
			AND TomarEnCuentaParaVacaciones ='S'
			AND IdEstadoAprob='Aprobado'
			and idempleado between @i_IdEmpleadoIni and @i_IdEmpleadoFin
		) A
		group by IdEmpresa,IdEmpleado 
		*/
)	
A	group by IdEmpresa,   IdEmpleado 



--sp_help ro_permiso_x_empleado
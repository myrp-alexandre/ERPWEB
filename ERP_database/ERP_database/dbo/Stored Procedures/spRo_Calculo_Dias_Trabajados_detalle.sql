CREATE proc [dbo].[spRo_Calculo_Dias_Trabajados_detalle]
(@i_idempresa int
,@i_fechaIni datetime
,@i_fechaFin datetime
,@i_IdEmpleadoIni numeric
,@i_IdEmpleadoFin numeric
)
as

		
			SELECT      IdEmpresa,   IdEmpleado,  Dias_a_disfrutar,fecha_desde,fecha_Hasta,fecha_retorno
			,'SOLVAC#'+cast(idsolicitudVaca as varchar(20)) as Tipo,observacion
			FROM         ro_Solicitud_Vacaciones
			where IdEmpresa=@i_idempresa 
			and Fecha_Desde between @i_fechaIni  and @i_fechaFin
			and idestadoAprobacion='APROBADO'
			and idempleado between @i_IdEmpleadoIni and @i_IdEmpleadoFin
		
		/*
		union
		
			SELECT IdEmpresa,IdEmpleado , cast((TiempoAusencia/8) as int) as TiempoAusencia
			,fecha,fecha,fecha
			,'PERM#'+cast(idpermiso as varchar(20)),observacion
			FROM ro_permiso_x_empleado 
			WHERE IdEmpresa =@i_idempresa 
			and Fecha between @i_fechaIni  and @i_fechaFin
			AND TomarEnCuentaParaVacaciones ='S'
			AND IdEstadoAprob='Aprobado'
			and idempleado between @i_IdEmpleadoIni and @i_IdEmpleadoFin
			*/
  create view vwro_rol_detalle_agrupado_x_proceso as
						  select IdEmpresa,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,IdEmpleado from ro_rol_detalle
						 where IdRubro=950
						 and Valor>0
						group by IdEmpresa,IdNominaTipo,IdNominaTipoLiqui,IdPeriodo,IdEmpleado
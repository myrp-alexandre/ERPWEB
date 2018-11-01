create view vwro_rol_detalle_x_rubro_acumulado as
select  A.IdEmpresa,A.IdNominaTipo,A.IdEmpleado, A.IdRubro,P.pe_anio ,SUM(A.Valor) as Valor
 from ro_rol_detalle_x_rubro_acumulado  as A, ro_periodo As P
 where A.IdEmpresa=P.IdEmpresa
 and A.IdPeriodo=P.IdPeriodo
 and Estado='PEN' and IdRubro=295 and IdEmpleado=82
 group by  A.IdEmpresa,A.IdNominaTipo,A.IdEmpleado, A.IdRubro ,P.pe_anio
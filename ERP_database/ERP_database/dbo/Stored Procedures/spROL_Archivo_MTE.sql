CREATE  PROCEDURE  [dbo].[spROL_Archivo_MTE] 
 @IdEmpresa int,
 @IdNominaTipo int,
 @IdNominatipoLiq int,
 @IdPeriodo int,
 @FechaI date,
 @FechaF date,
 @IdRubro Int
 AS
 
 /*

 declare

  @IdEmpresa int,
 @IdNominaTipo int,
 @IdNominatipoLiq int,
 @IdPeriodo int,
 @FechaI date,
 @FechaF date,
 @IdRubro Int


  set @IdEmpresa =1
 set @IdNominaTipo =1
 set @IdNominatipoLiq =4
 set @IdPeriodo =201705
 set @FechaI ='01/01/2017'
 set @FechaF ='31/12/2017'
 set @IdRubro=950
	
	*/
BEGIN
	
	SET NOCOUNT ON;

   
select Tab_Valores_Decimos_x_Empleado.*,tab_DiasTrabajados_x_Empleado.DiasTrabajados as Dias_Decimo,isnull(Tab_Dias_Faltados_x_Empl.TotalDiasF,0) as TotalDiasF,tab_DiasTrabajados_x_Empleado.DiasTrabajados-ISNULL( Tab_Dias_Faltados_x_Empl.TotalDiasF,0) as DiasA_considerar_Decimo 
from 
(
			select A.IdEmpresa, A.IdEmpleado, A.pe_apellido,A.pe_nombre,A.pe_cedulaRuc,A.CodigoSectorial,A.ca_descripcion, sum(A.valor) as Valor, A.pe_sexo,A.Estado,A.em_fechaIngaRol
			from 
			(
SELECT        dbo.ro_empleado.IdEmpresa, dbo.ro_empleado.IdEmpleado, dbo.tb_persona.pe_apellido, dbo.tb_persona.pe_nombre, dbo.tb_persona.pe_cedulaRuc, dbo.ro_empleado.CodigoSectorial, dbo.ro_cargo.ca_descripcion, 
                         dbo.ro_empleado.em_status, dbo.ro_periodo.pe_FechaIni, dbo.ro_periodo.pe_FechaFin, dbo.ro_rol_detalle.Valor, dbo.tb_persona.pe_sexo, dbo.ro_catalogo.ca_descripcion AS Estado, dbo.ro_empleado.em_fechaSalida, 
                         dbo.ro_empleado.em_fechaIngaRol
FROM            dbo.ro_empleado INNER JOIN
                         dbo.tb_persona ON dbo.ro_empleado.IdPersona = dbo.tb_persona.IdPersona INNER JOIN
                         dbo.ro_cargo ON dbo.ro_empleado.IdEmpresa = dbo.ro_cargo.IdEmpresa AND dbo.ro_empleado.IdCargo = dbo.ro_cargo.IdCargo INNER JOIN
                         dbo.ro_rol_detalle ON dbo.ro_empleado.IdEmpresa = dbo.ro_rol_detalle.IdEmpresa AND dbo.ro_empleado.IdEmpleado = dbo.ro_rol_detalle.IdEmpleado INNER JOIN
                         dbo.ro_periodo ON dbo.ro_rol_detalle.IdEmpresa = dbo.ro_periodo.IdEmpresa AND dbo.ro_rol_detalle.IdPeriodo = dbo.ro_periodo.IdPeriodo INNER JOIN
                         dbo.ro_catalogo ON dbo.ro_empleado.em_status = dbo.ro_catalogo.CodCatalogo
					       where ro_empleado.IdEmpresa=@IdEmpresa
						  -- and ro_empleado.em_status='EST_ACT'
						   and ro_empleado.em_estado='A'
						   and ro_rol_detalle.IdRubro= @IdRubro 
						  and dbo.ro_rol_detalle.IdPeriodo=@IdPeriodo
						

			) A
			group by A.IdEmpresa,A.IdEmpleado, A.pe_apellido,A.pe_nombre,A.pe_cedulaRuc,A.CodigoSectorial,A.ca_descripcion,A.pe_sexo,A.Estado,A.em_fechaIngaRol

) 
Tab_Valores_Decimos_x_Empleado  
left join (
		select C.IdEmpresa,C.IdEmpleado,  sum(diasDescuento) as TotalDiasF
		from ro_DiasFaltados_x_Empleado C
		where IdEmpresa=1
		and FechaDescuentaRol between @FechaI and @FechaF
		group by C.IdEmpresa,C.IdEmpleado
) Tab_Dias_Faltados_x_Empl 
on Tab_Valores_Decimos_x_Empleado.IdEmpresa=Tab_Dias_Faltados_x_Empl.IdEmpresa
and Tab_Valores_Decimos_x_Empleado.IdEmpleado=Tab_Dias_Faltados_x_Empl.IdEmpleado

left join
(
select CON.IdEmpresa,CON.IdEmpleado, IIF(FechaInicio< @FechaI,datediff(DD,@FechaI,@FechaF) , datediff(DD,FechaInicio,@FechaF)) as DiasTrabajados from ro_contrato as CON
where CON.EstadoContrato='ECT_ACT' and CON.Estado='A'and  CON.IdEmpresa=@IdEmpresa) tab_DiasTrabajados_x_Empleado
on tab_DiasTrabajados_x_Empleado.IdEmpresa=Tab_Valores_Decimos_x_Empleado.IdEmpresa and tab_DiasTrabajados_x_Empleado.IdEmpleado=Tab_Valores_Decimos_x_Empleado.IdEmpleado
end

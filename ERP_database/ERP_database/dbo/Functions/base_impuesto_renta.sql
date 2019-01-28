
 CREATE function [dbo].[base_impuesto_renta]
 (
  @IdEmpresa int,
  @IdNomina int,
  @IdNominaTipoLiqui int,
  @IdPeriodo int,
  @IdEmpleado int,
  @Anio int
 )
 returns float 
 as
 begin 
   declare 
   @base float,
   @ingresos float,
   @deducibles float,
   @FraccionBasica float,
   @Por_ImpFraccion_Exce float,
   @ImpFraccionBasica float,
   @ExcesoHasta float



SELECT      @deducibles=SUM(Valor)  
FROM            dbo.ro_empleado_proyeccion_gastos_det AS gast_det INNER JOIN
                         dbo.ro_empleado_proyeccion_gastos AS gast ON gast_det.IdEmpresa = gast.IdEmpresa AND gast_det.IdTransaccion = gast.IdTransaccion
          where gast.IdEmpresa=@IdEmpresa
		  and gast.IdEmpleado=@IdEmpleado
		  and gast.AnioFiscal=@Anio
		  group by gast.IdEmpresa, gast.IdEmpleado, gast.AnioFiscal

		  select @ingresos=SUM(Valor)
		  FROM            dbo.ro_rol AS rol INNER JOIN
                         dbo.ro_rol_detalle AS ro_det ON rol.IdEmpresa = ro_det.IdEmpresa AND rol.IdRol = ro_det.IdRol INNER JOIN
                         dbo.ro_rubro_tipo AS rub ON ro_det.IdEmpresa = rub.IdEmpresa AND ro_det.IdRubro = rub.IdRubro

			where ro_det.IdEmpresa=@IdEmpresa
		  and ro_det.IdEmpleado=@IdEmpleado
		  and rol.IdPeriodo=@IdPeriodo
		  and rol.IdEmpresa=@IdEmpleado
		  and rol.IdNominaTipo=IdNominaTipo
		  and rol.IdNominaTipoLiqui=@IdNominaTipoLiqui
		  and rol.IdPeriodo=@IdPeriodo
		  and rub.rub_aplicaIR=1
		   and rub.ru_tipo='I'
		  group by ro_det.IdEmpresa, ro_det.IdEmpleado


    set @ingresos=@ingresos*12
    set  @base=@ingresos-@deducibles

	select @ImpFraccionBasica=ImpFraccionBasica, @Por_ImpFraccion_Exce=Por_ImpFraccion_Exce, @FraccionBasica=FraccionBasica,@ExcesoHasta= ExcesoHasta  from (
	select ROW_NUMBER() over(partition by FraccionBasica order by FraccionBasica) as IdRow,FraccionBasica, Por_ImpFraccion_Exce, ImpFraccionBasica, ExcesoHasta  from ro_tabla_Impu_Renta
	
	 where AnioFiscal=AnioFiscal
	
	) a where a.IdRow=1
	and @base between a.FraccionBasica and a.ExcesoHasta

	set @base=((@base-@FraccionBasica)*@Por_ImpFraccion_Exce)+@ImpFraccionBasica

   return @base
 end;
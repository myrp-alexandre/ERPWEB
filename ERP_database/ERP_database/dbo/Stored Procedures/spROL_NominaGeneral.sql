-- exec [spROL_NominaGeneral] 1,'admin','DESARROLLO-3PC',1,1,201304,1,99,1,10000
CREATE PROCEDURE [dbo].[spROL_NominaGeneral]  
(
	@i_IdEmpresa Int	,		
	@i_IdUsuario varchar(50)		, 
	@i_nom_pc varchar(50),
	@i_IdNomina_Tipo Int,	
	@i_IdNomina_TipoLiqui Int			,
	@i_IdPeriodo int,
	@i_IdDivisionIni int,
	@i_IdDivisionFin int,
	@i_IdEmpleadoIni numeric(18,0),
	@i_IdEmpleadoFin numeric(18,0)

)  AS 
/*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/ 

 BEGIN
 
DECLARE @c_IdRubro VARCHAR(20)
DECLARE @C_rub_codigo VARCHAR(20)

declare @SSQL varchar(max)

 declare @W_NUMCOLUMNAS int
 
 set @W_NUMCOLUMNAS=10
 
 
 delete from tbROL_NominaGeneral 
 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc 
 
 
 insert into tbROL_NominaGeneral 
 (IdEmpresa		,IdEmpleado		,IdNomina_Tipo	,IdNomina_TipoLiqui	,IdPeriodo		,NomEmpleado
 ,IdDivision	,NomDivision	,IdDepartamento	,NomDepartamento	
 ,TotalIng
 ,TotalEgr			
 ,total
 ,nom_pc		,Fecha_Transac	,IdUsuario
 )
 
 
 
SELECT DISTINCT 
A.IdEmpresa		, A.IdEmpleado		, A.IdNomina_Tipo, A.IdNomina_TipoLiqui, A.IdPeriodo, C.pe_nombreCompleto
, B.IdDivision	,D.Descripcion		,B.IdDepartamento ,de.de_descripcion				   
,0
,0
,0
,@i_nom_pc		,GETDATE()		,@i_IdUsuario
FROM         ro_Ing_Egre_x_Empleado AS A, ro_empleado AS B ,tb_persona AS C ,ro_Division D,ro_Departamento as de
where                       
	A.IdEmpresa = B.IdEmpresa 
AND A.IdEmpleado = B.IdEmpleado 
and B.IdPersona = C.IdPersona

and B.IdEmpresa =D.IdEmpresa
and B.IdDivision=D.IdDivision

and de.IdEmpresa =B.IdEmpresa
and de.IdDepartamento=B.IdDepartamento 

and A.IdEmpresa = @i_IdEmpresa
AND A.IdEmpleado BETWEEN  @i_IdEmpleadoIni AND @i_IdEmpleadoFin
AND A.IdNomina_Tipo = @i_IdNomina_Tipo
AND A.IdNomina_TipoLiqui = @i_IdNomina_TipoLiqui
AND B.IdDivision BETWEEN @i_IdDivisionIni AND @i_IdDivisionFin
AND A.IdPeriodo = @i_IdPeriodo


                      
 
 
 ---------- actualizando el id reubro 
 
 

DECLARE @CountCol int
set @CountCol=0


--------------------------------------------------------------------------
-----------------------  /*INGRESOS */ ----------------------------------
    DECLARE RUBRO_CURSOR CURSOR FOR 
			select IdRubro, ru_codRolGen
			from (
					SELECT     A.IdRubro, B.ru_codRolGen,B.ru_orden
					FROM         ro_Ing_Egre_x_Empleado AS A INNER JOIN
					ro_rubro_tipo AS B ON A.IdRubro = B.IdRubro
					WHERE     A.IdEmpresa = @i_IdEmpresa
					AND		A.IdNomina_Tipo = @i_IdNomina_Tipo
					AND		A.IdNomina_TipoLiqui = @i_IdNomina_TipoLiqui
					AND		A.IdPeriodo = @i_IdPeriodo
					AND   B.ru_tipo='I'
					and A.Unid_Medida='$$$'
					
					group by  A.IdRubro, B.ru_codRolGen,B.ru_orden
					) A
			ORDER BY A.ru_orden

    
    OPEN RUBRO_CURSOR
    FETCH NEXT FROM RUBRO_CURSOR 
    INTO @c_IdRubro,@C_rub_codigo

    WHILE @@FETCH_STATUS = 0
    BEGIN

        set @CountCol=@CountCol+1
        
        
			set @SSQL=''
			set @SSQL=@SSQL + ' UPDATE tbROL_NominaGeneral         '
			set @SSQL=@SSQL + ' SET  IdRubroIng'+ cast(@CountCol as varchar(20)) + '='+ ''''+@c_IdRubro+''''
			set @SSQL=@SSQL + ' , NRubroIng'+ cast(@CountCol as varchar(20)) + '=' +''''+ @C_rub_codigo+''''
			set @SSQL=@SSQL + ', ValorIng'+ cast(@CountCol as varchar(20))+ '=0' 
			set @SSQL=@SSQL + ' WHERE    IdEmpresa=' + cast(@i_IdEmpresa  as varchar(20))
			set @SSQL=@SSQL + ' AND  IdNomina_Tipo=' + cast(@i_IdNomina_Tipo as varchar(20))
			set @SSQL=@SSQL + ' AND  IdNomina_TipoLiqui=' + cast(@i_IdNomina_TipoLiqui as varchar(20))
			set @SSQL=@SSQL + ' AND  IdPeriodo=' + cast(@i_IdPeriodo as varchar(20))
			set @SSQL=@SSQL + ' AND  nom_pc=' + '''' + @i_nom_pc   + ''''
			set @SSQL=@SSQL + ' AND  IdUsuario=' + '''' + @i_IdUsuario + ''''
			
			if (@CountCol<=@W_NUMCOLUMNAS)
			begin
				exec (@SSQL)
			end
			--print @SSQL
        
        FETCH NEXT FROM RUBRO_CURSOR 
        INTO @c_IdRubro,@C_rub_codigo
        END

    CLOSE RUBRO_CURSOR
    DEALLOCATE RUBRO_CURSOR
        
    --------------------------------------------------------------------------
-----------------------  /*INGRESOS */ ----------------------------------



set @CountCol=0

--------------------------------------------------------------------------
-----------------------  /*EGRESOS*/ ----------------------------------
    DECLARE RUBRO_CURSOR CURSOR FOR 
			select IdRubro, ru_codRolGen
			from (
					SELECT     A.IdRubro, B.ru_codRolGen,B.ru_orden
					FROM         ro_Ing_Egre_x_Empleado AS A INNER JOIN
					ro_rubro_tipo AS B ON A.IdRubro = B.IdRubro
					WHERE     A.IdEmpresa = @i_IdEmpresa
					AND		A.IdNomina_Tipo = @i_IdNomina_Tipo
					AND		A.IdNomina_TipoLiqui = @i_IdNomina_TipoLiqui
					AND		A.IdPeriodo = @i_IdPeriodo
					AND   B.ru_tipo='E'
					and A.Unid_Medida='$$$'
					
					group by  A.IdRubro, B.ru_codRolGen,B.ru_orden
					) A
			ORDER BY A.ru_orden

    
    OPEN RUBRO_CURSOR
    FETCH NEXT FROM RUBRO_CURSOR 
    INTO @c_IdRubro,@C_rub_codigo

    WHILE @@FETCH_STATUS = 0
    BEGIN

        set @CountCol=@CountCol+1
        
        
			set @SSQL=''
			set @SSQL=@SSQL + ' UPDATE tbROL_NominaGeneral         '
			set @SSQL=@SSQL + ' SET  IdRubroEgr'+ cast(@CountCol as varchar(20)) + '='+ ''''+@c_IdRubro+''''
			set @SSQL=@SSQL + ' , NRubroEgr'+ cast(@CountCol as varchar(20)) + '=' +''''+ @C_rub_codigo+''''
			set @SSQL=@SSQL + ', ValorEgr'+ cast(@CountCol as varchar(20))+ '=0' 
			set @SSQL=@SSQL + ' WHERE    IdEmpresa=' + cast(@i_IdEmpresa  as varchar(20))
			set @SSQL=@SSQL + ' AND  IdNomina_Tipo=' + cast(@i_IdNomina_Tipo as varchar(20))
			set @SSQL=@SSQL + ' AND  IdNomina_TipoLiqui=' + cast(@i_IdNomina_TipoLiqui as varchar(20))
			set @SSQL=@SSQL + ' AND  IdPeriodo=' + cast(@i_IdPeriodo as varchar(20))
			set @SSQL=@SSQL + ' AND  nom_pc=' + '''' + @i_nom_pc   + ''''
			set @SSQL=@SSQL + ' AND  IdUsuario=' + '''' + @i_IdUsuario + ''''
			
			if (@CountCol<=@W_NUMCOLUMNAS)
			begin
				exec (@SSQL)
			end
			
        
        FETCH NEXT FROM RUBRO_CURSOR 
        INTO @c_IdRubro,@C_rub_codigo
        END

    CLOSE RUBRO_CURSOR
    DEALLOCATE RUBRO_CURSOR
        
    --------------------------------------------------------------------------
-----------------------  /*EGRESOS */ ----------------------------------



		set @CountCol=1
                  
				while (@CountCol<=@W_NUMCOLUMNAS)
				begin
						

						set @SSQL=' update tbROL_NominaGeneral  '
						set @SSQL=@SSQL + ' set ValorIng'+ rtrim(cast(@CountCol as varchar(20))) + '=abs(B.Valor)'
						set @SSQL=@SSQL + ' FROM         tbROL_NominaGeneral AS A INNER JOIN '
						set @SSQL=@SSQL + ' vwRo_ro_Ing_Egre_x_Empleado_x_totalValor AS B ON A.IdEmpresa = B.IdEmpresa '
						set @SSQL=@SSQL + ' AND A.IdEmpleado = B.IdEmpleado AND A.IdNomina_Tipo = B.IdNomina_Tipo AND  '
						set @SSQL=@SSQL + ' A.IdNomina_TipoLiqui = B.IdNomina_TipoLiqui  '
						set @SSQL=@SSQL + ' AND A.IdPeriodo = B.IdPeriodo ' 
						set @SSQL=@SSQL + ' AND B.IdRubro = A.IdRubroIng' + rtrim(cast(@CountCol as varchar(20)))
						set @SSQL=@SSQL + ' WHERE    A.IdEmpresa=' + cast(@i_IdEmpresa  as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdNomina_Tipo=' + cast(@i_IdNomina_Tipo as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdNomina_TipoLiqui=' + cast(@i_IdNomina_TipoLiqui as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdPeriodo=' + cast(@i_IdPeriodo as varchar(20))
						set @SSQL=@SSQL + ' AND  A.nom_pc=' + '''' + @i_nom_pc   + ''''
						set @SSQL=@SSQL + ' AND  A.IdUsuario=' + '''' + @i_IdUsuario + ''''
						
							exec (@SSQL)
							
							
							
						set @SSQL=' update tbROL_NominaGeneral  '
						set @SSQL=@SSQL + ' set ValorEgr'+ rtrim(cast(@CountCol as varchar(20))) + '=abs(B.Valor)'
						set @SSQL=@SSQL + ' FROM         tbROL_NominaGeneral AS A INNER JOIN '
						set @SSQL=@SSQL + ' vwRo_ro_Ing_Egre_x_Empleado_x_totalValor AS B ON A.IdEmpresa = B.IdEmpresa '
						set @SSQL=@SSQL + ' AND A.IdEmpleado = B.IdEmpleado AND A.IdNomina_Tipo = B.IdNomina_Tipo AND  '
						set @SSQL=@SSQL + ' A.IdNomina_TipoLiqui = B.IdNomina_TipoLiqui  '
						set @SSQL=@SSQL + ' AND A.IdPeriodo = B.IdPeriodo ' 
						set @SSQL=@SSQL + ' AND B.IdRubro = A.IdRubroEgr' + rtrim(cast(@CountCol as varchar(20)))
						set @SSQL=@SSQL + ' WHERE    A.IdEmpresa=' + cast(@i_IdEmpresa  as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdNomina_Tipo=' + cast(@i_IdNomina_Tipo as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdNomina_TipoLiqui=' + cast(@i_IdNomina_TipoLiqui as varchar(20))
						set @SSQL=@SSQL + ' AND  A.IdPeriodo=' + cast(@i_IdPeriodo as varchar(20))
						set @SSQL=@SSQL + ' AND  A.nom_pc=' + '''' + @i_nom_pc   + ''''
						set @SSQL=@SSQL + ' AND  A.IdUsuario=' + '''' + @i_IdUsuario + ''''
						
							exec (@SSQL)
						
						
						
						
						set @CountCol=@CountCol+1

				end 
					
			
			
			exec (@SSQL)
 
 
 declare @W_AcuColuIng varchar(max)
 declare @W_AcuColuEgr varchar(max)

				set @CountCol=1
                  
                 set @W_AcuColuIng =''
                 set @W_AcuColuEgr =''
                  
				while (@CountCol<=@W_NUMCOLUMNAS)
				begin
					
					set @W_AcuColuIng =@W_AcuColuIng + ' ValorIng'+ rtrim(cast(@CountCol as varchar(20))) + '+'
					set @W_AcuColuEgr =@W_AcuColuEgr + ' ValorEgr'+ rtrim(cast(@CountCol as varchar(20))) + '+'
					
					set @CountCol=@CountCol+1
				
				end


				set @W_AcuColuIng =@W_AcuColuIng + '0'
				set @W_AcuColuEgr =@W_AcuColuEgr + '0'
					
				set @SSQL=''
				set @SSQL=@SSQL + ' update tbROL_NominaGeneral '
				set @SSQL=@SSQL + ' set TotalIng=' + @W_AcuColuIng
				set @SSQL=@SSQL + ' , TotalEgr=' + @W_AcuColuEgr
				---print @SSQL
				exec (@SSQL)


                  update tbROL_NominaGeneral
                  set total=TotalIng-TotalEgr
                      
 SELECT * FROM tbROL_NominaGeneral
 
 end
--EXEC spSys_Af_Insertar_cuentas_x_tipo_CtaGasto_CtaDeprAcum 2 , 1
CREATE PROCEDURE [dbo].[spSys_Af_Insertar_cuentas_x_tipo_CtaGasto_CtaDeprAcum]
(
@IdEmpresa_in INT,
@Ctas_activo bit
)
AS
BEGIN

DECLARE @IdEmpresa int, @IdActivoFijo numeric, @IdCtaCble_Activo varchar(20), @IdCtaCble_Dep_Acum varchar(20),@IdCtaCble_Gasto varchar(20), @IdCtaCble_Gastos_Depre varchar(20),
@Porcentaje int, @Secuencia int

IF(@Ctas_activo = 1)
	BEGIN --CURSOR PARA CUENTAS DE ACTIVO
			
			SET @Porcentaje = 100 -- NO CAMBIAR ESTO
			DELETE [dbo].[Af_Activo_fijo_CtasCbles] WHERE IdEmpresa = @IdEmpresa_in AND IdTipoCuenta = 'CTA_ACTIVO'
			DELETE [dbo].[Af_Activo_fijo_CtasCbles] WHERE IdEmpresa = @IdEmpresa_in AND IdTipoCuenta = 'CTA_DEPRE_ACUM'

			DECLARE Activos_cursor CURSOR FOR   
					SELECT        Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo_tipo.IdCtaCble_Activo, Af_Activo_fijo_tipo.IdCtaCble_Dep_Acum, Af_Activo_fijo_tipo.IdCtaCble_Gastos_Depre
					FROM            Af_Activo_fijo INNER JOIN
								Af_Activo_fijo_tipo ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_tipo.IdEmpresa AND Af_Activo_fijo.IdActivoFijoTipo = Af_Activo_fijo_tipo.IdActivoFijoTipo
					WHERE        (Af_Activo_fijo.IdEmpresa = @IdEmpresa_in)		

							OPEN			Activos_cursor --ABRO CURSOR
							FETCH NEXT FROM Activos_cursor
							INTO			@IdEmpresa, @IdActivoFijo, @IdCtaCble_Activo, @IdCtaCble_Dep_Acum,@IdCtaCble_Gastos_Depre

							IF @@FETCH_STATUS <> 0   
							PRINT 'NO HAY DATOS PARA CONTINUAR'       
  
							WHILE @@FETCH_STATUS = 0  
							BEGIN 
									INSERT INTO [dbo].[Af_Activo_fijo_CtasCbles]
									([IdEmpresa]           ,[IdActivoFijo]           ,[IdTipoCuenta]           ,[Secuencia]           ,[porc_distribucion]
									,[IdCtaCble]           ,[IdCentroCosto]          ,[Observacion])
									SELECT @IdEmpresa		  ,@IdActivoFijo			,'CTA_ACTIVO'			  ,1					 ,@Porcentaje
									,@IdCtaCble_Activo	  ,NULL						,' '

									INSERT INTO [dbo].[Af_Activo_fijo_CtasCbles]
									([IdEmpresa]           ,[IdActivoFijo]           ,[IdTipoCuenta]           ,[Secuencia]           ,[porc_distribucion]
									,[IdCtaCble]           ,[IdCentroCosto]          ,[Observacion])
									SELECT @IdEmpresa		  ,@IdActivoFijo			,'CTA_DEPRE_ACUM'		  ,1					 ,@Porcentaje
									,@IdCtaCble_Dep_Acum	  ,NULL					,' '
									
									INSERT INTO [dbo].[Af_Activo_fijo_CtasCbles]
									([IdEmpresa]           ,[IdActivoFijo]           ,[IdTipoCuenta]           ,[Secuencia]           ,[porc_distribucion]
									,[IdCtaCble]           ,[IdCentroCosto]          ,[Observacion])
									SELECT @IdEmpresa		  ,@IdActivoFijo			,'CTA_GASTOS_DEPRE'		  ,1					 ,@Porcentaje
									,@IdCtaCble_Gastos_Depre	  ,NULL					,' '

									SELECT * FROM [dbo].[Af_Activo_fijo_CtasCbles] WHERE IdEmpresa = @IdEmpresa AND IdActivoFijo = @IdActivoFijo 

									FETCH NEXT FROM Activos_cursor
									INTO @IdEmpresa, @IdActivoFijo, @IdCtaCble_Activo, @IdCtaCble_Dep_Acum,@IdCtaCble_Gastos_Depre
							END  
							CLOSE Activos_cursor  --CIERRO CURSOR
							DEALLOCATE Activos_cursor  

							
	END
/*ELSE
	BEGIN --CURSOR PARA CUENTAS DE GASTO
		
		 LO COMENTO PORQUE AL SUBIRLO AL FUENTE NO ENCUENTRA LA TABLA XXX PORQUE SE LA BORRA LUEGO DE TERMINAR DE SUBIR LAS CUENTAS

		DELETE [dbo].[Af_Activo_fijo_CtasCbles] WHERE IdEmpresa = @IdEmpresa_in AND IdTipoCuenta = 'CTA_GASTOS_DEPRE'
			
			DECLARE Activos_cursor CURSOR FOR   
			--REEMPLAZAR SOLO EL QUERY DEL CURSOR
					SELECT        Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, xxxCuentasActivoRioNilo$.cen_ctacon, cast(xxxCuentasActivoRioNilo$.cos_porcen as int),
					ROW_NUMBER() over(PARTITION BY Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo ORDER BY Af_Activo_fijo.IdEmpresa) AS Secuencia
					FROM            xxxCuentasActivoRioNilo$ INNER JOIN
					Af_Activo_fijo ON xxxCuentasActivoRioNilo$.ite_codigo = Af_Activo_fijo.CodActivoFijo
					WHERE        (Af_Activo_fijo.IdEmpresa = @IdEmpresa_in)

						OPEN		Activos_cursor --ABRO CURSOR
							FETCH NEXT FROM Activos_cursor
							INTO			@IdEmpresa, @IdActivoFijo, @IdCtaCble_Gasto, @Porcentaje, @Secuencia

							IF @@FETCH_STATUS <> 0   
							PRINT 'NO HAY DATOS PARA CONTINUAR'       
  
							WHILE @@FETCH_STATUS = 0  
							BEGIN 

								

								INSERT INTO [dbo].[Af_Activo_fijo_CtasCbles]
								([IdEmpresa]           ,[IdActivoFijo]           ,[IdTipoCuenta]           ,[Secuencia]           ,[porc_distribucion]
								,[IdCtaCble]           ,[IdCentroCosto]          ,[Observacion])
								SELECT @IdEmpresa		  ,@IdActivoFijo			,'CTA_GASTOS_DEPRE'		,@Secuencia			 ,@Porcentaje
								,@IdCtaCble_Gasto	  ,NULL					,' '

								SELECT * FROM [dbo].[Af_Activo_fijo_CtasCbles] WHERE IdEmpresa = @IdEmpresa AND IdActivoFijo = @IdActivoFijo and IdTipoCuenta = 'CTA_GASTOS_DEPRE'

								FETCH NEXT FROM Activos_cursor
								INTO @IdEmpresa, @IdActivoFijo, @IdCtaCble_Gasto, @Porcentaje, @Secuencia
							END  
						CLOSE Activos_cursor  --CIERRO CURSOR
						DEALLOCATE Activos_cursor  
			
			
	END*/
END
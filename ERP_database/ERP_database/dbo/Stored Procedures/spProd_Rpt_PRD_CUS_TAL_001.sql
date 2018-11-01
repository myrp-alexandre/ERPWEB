
 --- EXEC [spProd_Rpt_PRD_CUS_TAL_001] 1,3,'ADMIN','PC'

CREATE Procedure [dbo].[spProd_Rpt_PRD_CUS_TAL_001]
@IdEmpresa int,
@IdGestion numeric(18,0),
@NomPc varchar(50),
@IdUsuario varchar(50)
as
begin

		delete from  tbProd_Rpt_PRD_CUS_TAL_001 where IdUsuario=@IdUsuario and NomPc =@NomPc
	
		insert into tbProd_Rpt_PRD_CUS_TAL_001 
	--	SELECT * FROM tbProd_Rpt_PRD_CUS_TAL_001 
		select IdEmpresa,IdGestionProductiva,IdTurno,IdEmpleado_JefeTurno,IdProducto_MateriaPrima,Id_Bobina,Num_Orden,kg_Cargados,kg_producidos,IdProducto_Producido1
				,unidades_prd_1,pesokg_prd_1,IdProducto_Producido2,unidades_prd_2,pesokg_prd_2,kg_retazo_porcen,kg_retazo_valor,kg_chatarra_porcen,kg_chatarra_valor
				,kg_oxidacion_porcen,kg_oxidacion_valor,rendi_metal_historico,rendi_metal_real,rendi_metal_Diferencia, consumo_kilowatios,consumo_galones,cambio_prue_programado
				,cambio_prue_real,cambio_prue_porcentaje,CAST(hora_turno_ini AS VARCHAR(5)),CAST(hora_turno_fin AS VARCHAR(5)),hora_jornada,hora_productiva,hora_Paros,hora_Neta,hora_Hrs_Maquina,Ton_Programada,Ton_real,Ton_Eficiencia
				,Ton_TnHrNeta,Ton_kwTon,Ton_GlsTon,EficienciaProduccion,Estado, Fecha,Descripcion,Nombre_JefeTurno,IdTipoParada, Secuencia,CAST(HoraIni AS VARCHAR(5)),CAST(HoraFin AS VARCHAR(5)),Descripcion_Det 
				,causa,RTRIM(LTRIM(Materia_Prima)),RTRIM(LTRIM(Producto_1)),RTRIM(LTRIM(Producto_2 )),  Descripcion_Turno ,DescripcionTipoParada  , @NomPc as NomPc ,@IdUsuario as  IdUsuario 
		from vwProd_Rpt_GestionPordLaminados_Talme 
		Where IdEmpresa = @IdEmpresa and IdGestionProductiva=@IdGestion	 

end
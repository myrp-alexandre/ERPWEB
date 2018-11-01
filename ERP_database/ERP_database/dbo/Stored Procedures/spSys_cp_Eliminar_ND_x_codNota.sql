--exec [dbo].[spSys_cp_Eliminar_ND_x_codNota] 1,'4323714',0,'D'
CREATE PROCEDURE [dbo].[spSys_cp_Eliminar_ND_x_codNota]
(
@IdEmpresa_in int,
@num_nota varchar(50),
@Borrar bit,
@DebCre varchar(1)
)
AS
BEGIN
--set @num_fact = '%4323714%'
--set @Borrar = 0

declare 
@IdEmpresa int, 
@IdTipoCbte int, 
@IdCbteCble numeric, 
@contador int

select @contador = count(IdEmpresa) from cp_nota_DebCre where IdEmpresa = @IdEmpresa_in AND  cod_nota like '%'+@num_nota+'%'

IF(@contador = 1 )
BEGIN
select @IdEmpresa = IdEmpresa, @IdTipoCbte = IdTipoCbte_Nota, @IdCbteCble = IdCbteCble_Nota from cp_nota_DebCre where cod_nota like '%'+@num_nota+'%' and DebCre = @DebCre
		IF(@Borrar = 0)
		BEGIN
		select 'NOTA'
		select * from cp_nota_DebCre where IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
		select 'DETALLE DIARIO'
		select * from ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
		SELECT 'CABECERA DIARIO'
		select * from ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
		END
		ELSE
		BEGIN
		
		SELECT @contador = count(IdEmpresa_cxp) FROM cp_orden_pago_det WHERE IdEmpresa_cxp = @IdEmpresa and IdTipoCbte_cxp = @IdTipoCbte and IdCbteCble_cxp = @IdCbteCble
			IF(@contador = 0)
			BEGIN
			PRINT 'INSERT'
						INSERT INTO [dbo].[tb_sis_Log_Error_Vzen]
						([Fecha_Trans]						,[Detalle]						,[Tipo]						,[Clase]
						,[Pantalla]							,[Asamble]						,[Usuario]					,[Ip]						,[PC])
					VALUES
						(getdate()							,'IdEmpresa: '+CAST(@IdEmpresa AS VARCHAR(20))+' IdTipoCbte: '+CAST(@IdTipoCbte AS VARCHAR(20))+' IdCbteCble: '+CAST(@IdCbteCble AS VARCHAR(20))+' CodNota: '+@num_nota,''						,'[spSys_cp_Eliminar_ND]'		,''
						,
						''						,''						,''						,'')
			PRINT 'NOTA'
			DELETE cp_nota_DebCre where IdEmpresa = @IdEmpresa and IdTipoCbte_Nota = @IdTipoCbte and IdCbteCble_Nota = @IdCbteCble
			PRINT 'DETALLE DIARIO'
			DELETE ct_cbtecble_det where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
			PRINT 'CABECERA DIARIO'
			DELETE ct_cbtecble where IdEmpresa = @IdEmpresa and IdTipoCbte = @IdTipoCbte and IdCbteCble = @IdCbteCble
			END
			ELSE
			SELECT 'EXISTEN ORDENES DE PAGO ASOCIADAS A ESTA NOTA'
		END
END
ELSE
IF(@contador > 1)
BEGIN
SELECT 'EXISTE MAS DE UNA NOTA CON EL NUMERO INGRESADO'
END
ELSE
IF(@contador = 0)
BEGIN
SELECT 'NO EXISTE UNA NOTA CON EL NUMERO INDICADO'
END
END
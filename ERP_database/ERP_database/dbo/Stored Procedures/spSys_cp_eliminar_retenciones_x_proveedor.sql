--EXEC spSys_cp_eliminar_retenciones_x_proveedor 2,'11407',0
CREATE PROCEDURE [dbo].[spSys_cp_eliminar_retenciones_x_proveedor]
(
@IdEmpresa int,
@NumRetencion varchar(20),
@Borrar bit
)
AS
BEGIN
/*
SET @IdEmpresa = 1
SET @NumRetencion = '%158651'
SET @Borrar = 0
*/
DECLARE @IdEmpresa_rt int
DECLARE @IdRetencion_rt numeric(18,0)

select @IdEmpresa_rt = IdEmpresa, @IdRetencion_rt = IdRetencion from cp_retencion where IdEmpresa = @IdEmpresa and NumRetencion like '%'+@NumRetencion

if(@IdRetencion_rt is null)
	BEGIN
		SELECT 'EL NUMERO DE RETENCION NO ESTA SIENDO UTILIZADO'
		IF(@Borrar = 0)
			BEGIN
				SELECT * FROM tb_sis_Documento_Tipo_Talonario WHERE CodDocumentoTipo = 'RETEN' AND NumDocumento like '%'+ @NumRetencion and IdEmpresa = @IdEmpresa
			END
		ELSE
			BEGIN
				UPDATE tb_sis_Documento_Tipo_Talonario SET Usado = 0 , Estado = 'A' WHERE CodDocumentoTipo = 'RETEN' AND NumDocumento like '%'+ @NumRetencion and IdEmpresa = @IdEmpresa 
				SELECT * FROM tb_sis_Documento_Tipo_Talonario WHERE CodDocumentoTipo = 'RETEN' AND NumDocumento like '%'+ @NumRetencion and IdEmpresa = @IdEmpresa
			END
		
	END
ELSE
	BEGIN
	DECLARE @IdEmpresa_ct int
	DECLARE @IdTipoCbte_ct int
	DECLARE @IdCbteCble_ct numeric(18,0)

	SELECT @IdEmpresa_ct = ct_IdEmpresa, @IdTipoCbte_ct = ct_IdTipoCbte, @IdCbteCble_ct = ct_IdCbteCble 
	FROM cp_retencion_x_ct_cbtecble where rt_IdEmpresa = @IdEmpresa_rt and rt_IdRetencion = @IdRetencion_rt

	IF(@IdEmpresa_ct IS NULL)
		BEGIN
			SELECT 'LA RETENCION NO TIENE DIARIO'
		END
	
	IF(@Borrar = 0)
		BEGIN
			SELECT * FROM cp_retencion_x_ct_cbtecble where rt_IdEmpresa = @IdEmpresa_rt and rt_IdRetencion = @IdRetencion_rt
			SELECT * FROM ct_cbtecble_det where IdEmpresa = @IdEmpresa_ct and IdTipoCbte = @IdTipoCbte_ct and IdCbteCble = @IdCbteCble_ct		
			SELECT * FROM ct_cbtecble where IdEmpresa = @IdEmpresa_ct and IdTipoCbte = @IdTipoCbte_ct and IdCbteCble = @IdCbteCble_ct
			SELECT * FROM cp_retencion_det where IdEmpresa = @IdEmpresa_rt and IdRetencion = @IdRetencion_rt
			SELECT * FROM cp_retencion where IdEmpresa = @IdEmpresa_rt and IdRetencion = @IdRetencion_rt
			SELECT * FROM tb_sis_Documento_Tipo_Talonario WHERE CodDocumentoTipo = 'RETEN' AND NumDocumento like '%'+ @NumRetencion and IdEmpresa = @IdEmpresa
		END
	ELSE
		BEGIN
			DELETE cp_retencion_x_ct_cbtecble where rt_IdEmpresa = @IdEmpresa_rt and rt_IdRetencion = @IdRetencion_rt
			DELETE ct_cbtecble_det where IdEmpresa = @IdEmpresa_ct and IdTipoCbte = @IdTipoCbte_ct and IdCbteCble = @IdCbteCble_ct		
			DELETE ct_cbtecble where IdEmpresa = @IdEmpresa_ct and IdTipoCbte = @IdTipoCbte_ct and IdCbteCble = @IdCbteCble_ct
			DELETE cp_retencion_det where IdEmpresa = @IdEmpresa_rt and IdRetencion = @IdRetencion_rt
			DELETE cp_retencion where IdEmpresa = @IdEmpresa_rt and IdRetencion = @IdRetencion_rt
			UPDATE tb_sis_Documento_Tipo_Talonario SET Usado = 0 , Estado = 'A' WHERE CodDocumentoTipo = 'RETEN' AND NumDocumento like '%'+ @NumRetencion and IdEmpresa = @IdEmpresa
		END
	
	END
END
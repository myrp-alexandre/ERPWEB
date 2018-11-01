--EXEC [dbo].[spBAN_Rpt007_saldos] 3,'01/01/2017','31/01/2017','admin'
CREATE procedure [dbo].[spBAN_Rpt007_saldos]
(
@IdEmpresa int,
@Fecha_ini datetime,
@Fecha_fin datetime,
@IdUsuario varchar(20)
)
as
begin
/*
SET @IdEmpresa = 1
SET @Fecha_ini = '15/10/2016'
SET @Fecha_fin = '31/12/2016'
SET @IdUsuario = 'admin'
*/
delete [dbo].[ba_BAN_Rpt007] where IdUsuario = @IdUsuario

INSERT INTO [dbo].[ba_BAN_Rpt007]
           ([IdEmpresa]           ,[IdBanco]           ,[IdUsuario]           ,[nom_cuenta_banco]
           ,[Saldo_inicial]	      ,[Saldo_final])
select		IdEmpresa			  ,IdBanco			   ,@IdUsuario			  ,ba_descripcion,
			0					  ,0 
from ba_Banco_Cuenta	WHERE IdEmpresa = @IdEmpresa

UPDATE [dbo].[ba_BAN_Rpt007]
   SET [Saldo_inicial] = A.dc_Valor      
FROM
(
	SELECT        ba_Banco_Cuenta.IdEmpresa, ba_Banco_Cuenta.IdBanco, SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor, ba_Banco_Cuenta.ba_descripcion
	FROM            ct_cbtecble_det INNER JOIN
				ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
				ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
				ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
	where ba_Banco_Cuenta.IdEmpresa = @IdEmpresa and ct_cbtecble.cb_Fecha < @Fecha_ini
	GROUP BY ba_Banco_Cuenta.IdEmpresa, ba_Banco_Cuenta.IdBanco, ba_Banco_Cuenta.ba_descripcion
) A
WHERE [ba_BAN_Rpt007].IdEmpresa = A.IdEmpresa
and [ba_BAN_Rpt007].IdBanco = A.IdBanco
and [ba_BAN_Rpt007].IdUsuario = @IdUsuario

UPDATE [dbo].[ba_BAN_Rpt007]
   SET [Saldo_final] = A.dc_Valor      
FROM
(
		SELECT        ba_Banco_Cuenta.IdEmpresa, ba_Banco_Cuenta.IdBanco, SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor, ba_Banco_Cuenta.ba_descripcion
		FROM            ct_cbtecble_det INNER JOIN
					ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
					ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
					ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
		where ba_Banco_Cuenta.IdEmpresa = @IdEmpresa and ct_cbtecble.cb_Fecha <= @Fecha_fin
		GROUP BY ba_Banco_Cuenta.IdEmpresa, ba_Banco_Cuenta.IdBanco, ba_Banco_Cuenta.ba_descripcion
 ) as A
WHERE [ba_BAN_Rpt007].IdEmpresa = A.IdEmpresa
and [ba_BAN_Rpt007].IdBanco = A.IdBanco
and [ba_BAN_Rpt007].IdUsuario = @IdUsuario
 

SELECT * FROM [dbo].[ba_BAN_Rpt007] WHERE IdUsuario = @IdUsuario
end
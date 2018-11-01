--EXEC fj_servindustrias.spBAN_FJ_Rpt004_saldos 1,'201705','201708','admin'
CREATE procedure [Fj_servindustrias].[spBAN_FJ_Rpt004_saldos]
(
@IdEmpresa int,
@IdPeriodo_ini int,
@IdPeriodo_fin int,
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

update [ba_BAN_Rpt007] set Saldo_inicial = isnull(a.co_SaldoBanco_anterior,0)
FROM(
SELECT ba_Conciliacion.IdEmpresa, ba_Conciliacion.IdBanco, ba_Conciliacion.IdPeriodo, ba_Conciliacion.co_SaldoBanco_anterior
FROM ba_Conciliacion
where ba_Conciliacion.IdEmpresa = @IdEmpresa and ba_Conciliacion.IdPeriodo = @IdPeriodo_ini
) A
WHERE A.IdEmpresa = [ba_BAN_Rpt007].IdEmpresa
AND A.IdBanco = [ba_BAN_Rpt007].IdBanco
AND [ba_BAN_Rpt007].IdUsuario = @IdUsuario

update [ba_BAN_Rpt007] set Saldo_final = isnull(a.co_SaldoBanco_EstCta,0)
FROM(
SELECT ba_Conciliacion.IdEmpresa, ba_Conciliacion.IdBanco, ba_Conciliacion.IdPeriodo, ba_Conciliacion.co_SaldoBanco_EstCta
FROM ba_Conciliacion
where ba_Conciliacion.IdEmpresa = @IdEmpresa and ba_Conciliacion.IdPeriodo = @IdPeriodo_fin
) A
WHERE A.IdEmpresa = [ba_BAN_Rpt007].IdEmpresa
AND A.IdBanco = [ba_BAN_Rpt007].IdBanco
AND [ba_BAN_Rpt007].IdUsuario = @IdUsuario

SELECT * FROM [dbo].[ba_BAN_Rpt007] WHERE IdUsuario = @IdUsuario and IdEmpresa = @IdEmpresa
end
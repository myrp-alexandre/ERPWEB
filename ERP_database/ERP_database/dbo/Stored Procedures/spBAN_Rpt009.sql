
--exec [spBAN_Rpt009] 1,'01/07/2016','14/07/2016'

CREATE PROCEDURE [dbo].[spBAN_Rpt009]
	@IdEmpresa int,
	@Fecha_ini DATETIME,
	@fecha_fin DATETIME	 
AS
BEGIN
delete [dbo].[ba_BAN_Rpt009]

BEGIN --INSERTO SALDO INICIAL
INSERT INTO [dbo].[ba_BAN_Rpt009]
           ([IdEmpresa]				,[IdCtaCble]			,[Saldo_anterior]           ,[Ingreso]
           ,[Egreso]				,[Saldo_final]          ,[fecha_ini]				,[fecha_fin]
		   ,[nom_Banco])
select	A.IdEmpresa,				A.IdCtaCble,			 A.dc_Valor,				0
		,0							,0						,@Fecha_ini				,@fecha_fin
		,A.ba_descripcion
FROM
(
SELECT   ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco, 
		sum(ct_cbtecble_det.dc_Valor) as dc_Valor
		FROM            ct_cbtecble INNER JOIN
		ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
		ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
		ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
		where ct_cbtecble.cb_Fecha < @Fecha_ini
		and ct_cbtecble.IdEmpresa= @IdEmpresa
		group by ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco

) A
END

BEGIN --INSERTO INGRESOS
update [dbo].[ba_BAN_Rpt009] 
set Ingreso = A.dc_Valor
FROM
(
		SELECT     ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco, 
		sum(ct_cbtecble_det.dc_Valor) as dc_Valor
		FROM            ct_cbtecble INNER JOIN
		ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
		ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
		ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
		where ct_cbtecble.cb_Fecha BETWEEN @Fecha_ini AND @fecha_fin
		and ct_cbtecble.IdEmpresa= @IdEmpresa
		AND dc_Valor > 0
		group by ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco		
) A
where A.IdEmpresa = [ba_BAN_Rpt009].IdEmpresa
and A.IdCtaCble = [ba_BAN_Rpt009].IdCtaCble
END

BEGIN --INSERTO EGRESOS
update [dbo].[ba_BAN_Rpt009] 
set Egreso = A.dc_Valor
FROM
(
		SELECT     ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco
		,sum(ct_cbtecble_det.dc_Valor) as dc_Valor
		FROM            ct_cbtecble INNER JOIN
		ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
		ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
		ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
		where ct_cbtecble.cb_Fecha BETWEEN @Fecha_ini AND @fecha_fin
		and ct_cbtecble.IdEmpresa= @IdEmpresa
		AND dc_Valor < 0
		group by ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco
		
) A
where A.IdEmpresa = [ba_BAN_Rpt009].IdEmpresa
and A.IdCtaCble = [ba_BAN_Rpt009].IdCtaCble
END

BEGIN --INSERTO SALDO FINAL
update [dbo].[ba_BAN_Rpt009] 
set Saldo_final = A.dc_Valor
FROM
(
		SELECT      ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco, 
		sum(ct_cbtecble_det.dc_Valor) as dc_Valor
		FROM            ct_cbtecble INNER JOIN
		ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
		ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
		ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
		where ct_cbtecble.cb_Fecha <= @fecha_fin
		and ct_cbtecble.IdEmpresa= @IdEmpresa
		group by ct_cbtecble.IdEmpresa, ct_cbtecble_det.IdCtaCble, ba_Banco_Cuenta.ba_descripcion, ba_Banco_Cuenta.ba_Num_Cuenta, ba_Banco_Cuenta.IdBanco
		
) A
where A.IdEmpresa = [ba_BAN_Rpt009].IdEmpresa
and A.IdCtaCble = [ba_BAN_Rpt009].IdCtaCble
END

BEGIN --RETORNO LISTA
SELECT * FROM [ba_BAN_Rpt009]
END

END
-- exec spCONTA_Rpt010 1,'01/11/2016','30/11/2016',10,0
CREATE  proc [dbo].[spCONTA_Rpt010]
(
 @i_IdEmpresa int
,@i_FechaIni datetime
,@i_FechaFin datetime
,@i_IdPunto_cargo_grupo int
,@i_Mostrar_reg_cero bit
)
as
begin
/*
declare @i_IdEmpresa int
declare @i_FechaIni datetime
declare @i_FechaFin datetime
declare @i_IdPunto_cargo_grupo int


SET @i_IdEmpresa =1
SET @i_FechaIni ='01/06/2016'
SET @i_FechaFin ='30/06/2016'
set @i_IdPunto_cargo_grupo =1
*/



delete [dbo].[tbCONTA_Rpt010]


INSERT INTO [dbo].[tbCONTA_Rpt010]
([IdEmpresa]			,[IdPunto_cargo_grupo]	,[IdPunto_cargo]	,[IdCtaCble]					,[nom_Punto_cargo]	
,[Saldo_Anterior]		,[Debito]				,[Credito]		,[Saldo_Total])

SELECT DISTINCT 
A.IdEmpresa				, A.IdPunto_cargo_grupo		, A.IdPunto_cargo,ct_cbtecble_det.IdCtaCble		, A.nom_punto_cargo
,0						,0						,0				,0
FROM            ct_cbtecble INNER JOIN
                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                         ct_punto_cargo AS A INNER JOIN
                         ct_punto_cargo_grupo ON A.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND A.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo ON 
                         ct_cbtecble_det.IdEmpresa = A.IdEmpresa AND ct_cbtecble_det.IdPunto_cargo = A.IdPunto_cargo AND 
                         ct_cbtecble_det.IdPunto_cargo_grupo = A.IdPunto_cargo_grupo
WHERE        (A.IdEmpresa = @i_IdEmpresa) AND (A.IdPunto_cargo_grupo = @i_IdPunto_cargo_grupo) 
AND ct_cbtecble.cb_Fecha <= @i_FechaFin
ORDER BY A.IdPunto_cargo


--select Sum_x_Pto_Cargo.dc_Valor,
-----   saldo  Anterior
UPDATE tbCONTA_Rpt010
set Saldo_Anterior=Sum_x_Pto_Cargo.dc_Valor
from
(

		SELECT        ct_cbtecble.IdEmpresa, SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo
		,ct_cbtecble_det.IdCtaCble
		FROM            ct_cbtecble_det INNER JOIN
								 ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
								 ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
								 ct_punto_cargo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND ct_cbtecble_det.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo
		WHERE        (ct_cbtecble.cb_Fecha < @i_FechaIni)
		GROUP BY ct_cbtecble.IdEmpresa, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo,ct_cbtecble_det.IdCtaCble
		HAVING        (ct_cbtecble.IdEmpresa = @i_IdEmpresa)
		and ct_punto_cargo.IdPunto_cargo_grupo=@i_IdPunto_cargo_grupo

) as Sum_x_Pto_Cargo, tbCONTA_Rpt010 as tb_data
where tb_data.idempresa=Sum_x_Pto_Cargo.IdEmpresa
and tb_data.idpunto_cargo=Sum_x_Pto_Cargo.IdPunto_cargo
and tb_data.IdPunto_cargo_grupo =Sum_x_Pto_Cargo.IdPunto_cargo_grupo
and tb_data.IdCtaCble=Sum_x_Pto_Cargo.IdCtaCble

--=======================================


UPDATE tbCONTA_Rpt010
set Debito=Sum_x_Pto_Cargo.dc_Valor
from
(
		SELECT        ct_cbtecble.IdEmpresa, SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo
		,ct_cbtecble_det.IdCtaCble
		FROM            ct_cbtecble_det INNER JOIN
								 ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
								 ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
								 ct_punto_cargo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND ct_cbtecble_det.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo
		WHERE        (ct_cbtecble.cb_Fecha between @i_FechaIni and @i_FechaFin)
		and ct_cbtecble_det.dc_Valor>0 --debito
		GROUP BY ct_cbtecble.IdEmpresa, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo,ct_cbtecble_det.IdCtaCble
		HAVING        (ct_cbtecble.IdEmpresa = @i_IdEmpresa)
		and ct_punto_cargo.IdPunto_cargo_grupo=@i_IdPunto_cargo_grupo

) as Sum_x_Pto_Cargo, tbCONTA_Rpt010 as tb_data
where tb_data.idempresa=Sum_x_Pto_Cargo.IdEmpresa
and tb_data.idpunto_cargo=Sum_x_Pto_Cargo.IdPunto_cargo
and tb_data.IdPunto_cargo_grupo=Sum_x_Pto_Cargo.IdPunto_cargo_grupo
and tb_data.IdCtaCble=Sum_x_Pto_Cargo.IdCtaCble
---======================================


UPDATE tbCONTA_Rpt010
set credito=Sum_x_Pto_Cargo.dc_Valor*-1
from
(
		SELECT        ct_cbtecble.IdEmpresa, SUM(ct_cbtecble_det.dc_Valor) AS dc_Valor, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo
		,ct_cbtecble_det.IdCtaCble
		FROM            ct_cbtecble_det INNER JOIN
								 ct_cbtecble ON ct_cbtecble_det.IdEmpresa = ct_cbtecble.IdEmpresa AND ct_cbtecble_det.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
								 ct_cbtecble_det.IdCbteCble = ct_cbtecble.IdCbteCble INNER JOIN
								 ct_punto_cargo ON ct_cbtecble_det.IdEmpresa = ct_punto_cargo.IdEmpresa AND ct_cbtecble_det.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo
		WHERE        (ct_cbtecble.cb_Fecha between @i_FechaIni and @i_FechaFin)
		and ct_cbtecble_det.dc_Valor<0 --credito
		GROUP BY ct_cbtecble.IdEmpresa, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.IdPunto_cargo_grupo,ct_cbtecble_det.IdCtaCble
		HAVING        (ct_cbtecble.IdEmpresa = @i_IdEmpresa)
		and ct_punto_cargo.IdPunto_cargo_grupo=@i_IdPunto_cargo_grupo

) as Sum_x_Pto_Cargo, tbCONTA_Rpt010 as tb_data
where tb_data.idempresa=Sum_x_Pto_Cargo.IdEmpresa
and tb_data.idpunto_cargo=Sum_x_Pto_Cargo.IdPunto_cargo
and tb_data.IdPunto_cargo_grupo=Sum_x_Pto_Cargo.IdPunto_cargo_grupo
and tb_data.IdCtaCble=Sum_x_Pto_Cargo.IdCtaCble
------================================


UPDATE tbCONTA_Rpt010
set Saldo_Total=ROUND( Saldo_Anterior,2) + round( debito,2) -ROUND( credito,2)


if (@i_Mostrar_reg_cero =0)
begin

	delete 
	from tbCONTA_Rpt010 
	where IdEmpresa=@i_IdEmpresa 
	and Saldo_Total=0

end 



update tbCONTA_Rpt010
set nom_Punto_cargo = nom_Punto_cargo  + ' Saldo x IdCtaCble:' + IdCtaCble
from (
	select A.IdEmpresa,A.IdPunto_cargo, COUNT(*) T
	from tbCONTA_Rpt010 A 
	group by A.IdEmpresa,A.IdPunto_cargo having COUNT(*)>1
	) Grup,tbCONTA_Rpt010 B
where Grup.IdEmpresa=B.IdEmpresa and Grup.IdPunto_cargo=B.IdPunto_cargo


---============ select  de salida

SELECT        tbCONTA_Rpt010.IdEmpresa, tbCONTA_Rpt010.IdPunto_cargo_grupo, tbCONTA_Rpt010.IdPunto_cargo, tbCONTA_Rpt010.IdCtaCble, 
                         tbCONTA_Rpt010.nom_Punto_cargo, tbCONTA_Rpt010.Saldo_Anterior, tbCONTA_Rpt010.Debito, tbCONTA_Rpt010.Credito, tbCONTA_Rpt010.Saldo_Total, 
                         tb_empresa.em_nombre AS nom_empresa, ct_punto_cargo_grupo.nom_punto_cargo_grupo
FROM            tbCONTA_Rpt010 INNER JOIN
                         tb_empresa ON tbCONTA_Rpt010.IdEmpresa = tb_empresa.IdEmpresa INNER JOIN
                         ct_punto_cargo_grupo ON tbCONTA_Rpt010.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         tbCONTA_Rpt010.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo
WHERE ROUND(tbCONTA_Rpt010.Saldo_Anterior,2) != 0 OR ROUND(tbCONTA_Rpt010.Saldo_Total,2)!=0 OR ROUND(tbCONTA_Rpt010.Credito,2) != 0 OR ROUND(tbCONTA_Rpt010.Debito,2)!=0





end
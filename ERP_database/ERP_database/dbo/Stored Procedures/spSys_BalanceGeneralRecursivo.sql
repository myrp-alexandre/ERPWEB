create proc [dbo].[spSys_BalanceGeneralRecursivo]
as
WITH movi(IdPadre, IdCta,total,[LEVEL])
AS
(
select A.IdCtaCblePadre		,A.IdCtaCble ,A.valor
, CAST(A.IdCtaCble AS VARCHAR(MAX)) + '\' AS [LEVEL]
from vwSys_Cbte_Recursivo A
where A.IdCtaCblePadre is null

union all
select  
		t.IdCtaCblePadre	,t.IdCtaCble	,t.valor
,CAST(p.[LEVEL] AS VARCHAR(MAX))  + CAST(t.IdCtaCble AS VARCHAR(MAX)) + '\' AS [LEVEL]
from vwSys_Cbte_Recursivo t INNER JOIN
	movi as p on p.IdCta=t.IdCtaCblePadre
)
SELECT  *,
        (
        SELECT SUM( total) FROM movi 
        WHERE [Level] LIKE v.[LEVEL] + '%') --/ Level_Qty
FROM    movi v
ORDER BY [LEVEL]
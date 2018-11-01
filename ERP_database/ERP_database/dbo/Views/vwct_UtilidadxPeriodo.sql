
CREATE view [dbo].[vwct_UtilidadxPeriodo]
as
SELECT     A.IdEmpresa, A.IdanioFiscal, A.IdPeriodo, ISNULL(B.Utilidad_Anterior,0) Utilidad_Anterior 
, ISNULL(D.Utilidad_Periodo,0) Utilidad_Periodo , ISNULL(C.Utilidad_acum,0) Utilidad_acum
FROM         ct_periodo AS A LEFT OUTER JOIN
                      vwct_UtilidadxPeriodo_Saldo_PeriodoActual AS D ON A.IdEmpresa = D.IdEmpresa AND A.IdanioFiscal = D.IdAnioF AND A.IdPeriodo = D.IdPeriodo LEFT OUTER JOIN
                      vwct_UtilidadxPeriodo_Saldo_Acumulado AS C ON A.IdEmpresa = C.IdEmpresa AND A.IdPeriodo = C.IdPeriodo AND A.IdanioFiscal = C.IdAnioF LEFT OUTER JOIN
                      vwct_UtilidadxPeriodo_Saldo_Anterior AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdPeriodo = B.IdPeriodo AND A.IdanioFiscal = B.IdAnioF
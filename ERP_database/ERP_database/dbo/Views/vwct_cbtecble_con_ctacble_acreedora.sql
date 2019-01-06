CREATE view [dbo].[vwct_cbtecble_con_ctacble_acreedora]
as
SELECT        IdEmpresa, IdTipoCbte, IdCbteCble, MAX(IdCtaCble_Acreedora) AS IdCtaCble_Acreedora
FROM            (SELECT        cbte_d.IdEmpresa, cbte_d.IdTipoCbte, cbte_d.IdCbteCble, cbte_d.IdCtaCble AS IdCtaCble_Acreedora
                          FROM            dbo.ct_cbtecble_det AS cbte_d INNER JOIN
                                                    dbo.cp_orden_giro AS OG ON cbte_d.IdEmpresa = OG.IdEmpresa AND cbte_d.IdTipoCbte = OG.IdTipoCbte_Ogiro AND cbte_d.IdCbteCble = OG.IdCbteCble_Ogiro
                          WHERE        (cbte_d.dc_Valor < 0) AND EXISTS
                                                        (SELECT        IdEmpresa
                                                          FROM            dbo.cp_proveedor AS cl_pr
                                                          WHERE        (IdEmpresa = cbte_d.IdEmpresa) AND (IdCtaCble_CXP = cbte_d.IdCtaCble))
                          UNION ALL
                          SELECT        cbte_d.IdEmpresa, cbte_d.IdTipoCbte, cbte_d.IdCbteCble, cbte_d.IdCtaCble AS IdCtaCble_Acreedora
                          FROM            dbo.cp_nota_DebCre INNER JOIN
                                                   dbo.ct_cbtecble_det AS cbte_d ON dbo.cp_nota_DebCre.IdEmpresa = cbte_d.IdEmpresa AND dbo.cp_nota_DebCre.IdTipoCbte_Nota = cbte_d.IdTipoCbte AND 
                                                   dbo.cp_nota_DebCre.IdCbteCble_Nota = cbte_d.IdCbteCble
                          WHERE        (cbte_d.dc_Valor < 0) AND (dbo.cp_nota_DebCre.DebCre = 'D') AND EXISTS
                                                       (SELECT        IdEmpresa
                                                         FROM            dbo.cp_proveedor AS cl_pr
                                                         WHERE        (IdEmpresa = cbte_d.IdEmpresa) AND (IdCtaCble_CXP = cbte_d.IdCtaCble))
                          UNION ALL
                          SELECT        d.IdEmpresa_cxp, d.IdTipoCbte_cxp, d.IdCbteCble_cxp, ct.IdCtaCble
                          FROM            dbo.cp_orden_pago AS c INNER JOIN
                                                   dbo.cp_orden_pago_det AS d ON c.IdEmpresa = d.IdEmpresa AND c.IdOrdenPago = d.IdOrdenPago LEFT OUTER JOIN
                                                   dbo.ct_cbtecble_det AS ct ON d.IdEmpresa_cxp = ct.IdEmpresa AND d.IdCbteCble_cxp = ct.IdCbteCble AND d.IdTipoCbte_cxp = ct.IdTipoCbte
                          WHERE        (c.IdTipo_op <> 'FACT_PROVEE') AND (ct.dc_Valor < 0)) AS Querry
GROUP BY IdEmpresa, IdTipoCbte, IdCbteCble
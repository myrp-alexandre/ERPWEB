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
                          SELECT        A.IdEmpresa, A.IdTipoCbte, A.IdCbteCble, A.IdCtaCble AS IdCtaCble_Acreedora
                          FROM            dbo.cp_orden_pago_det INNER JOIN
                                                   dbo.cp_orden_pago ON dbo.cp_orden_pago_det.IdEmpresa = dbo.cp_orden_pago.IdEmpresa AND dbo.cp_orden_pago_det.IdOrdenPago = dbo.cp_orden_pago.IdOrdenPago INNER JOIN
                                                   dbo.ct_cbtecble_det AS A ON dbo.cp_orden_pago_det.IdEmpresa_cxp = A.IdEmpresa AND dbo.cp_orden_pago_det.IdTipoCbte_cxp = A.IdTipoCbte AND 
                                                   dbo.cp_orden_pago_det.IdCbteCble_cxp = A.IdCbteCble INNER JOIN
                                                   dbo.vwtb_persona_beneficiario ON dbo.cp_orden_pago.IdEmpresa = dbo.vwtb_persona_beneficiario.IdEmpresa AND dbo.cp_orden_pago.IdTipo_Persona = dbo.vwtb_persona_beneficiario.IdTipo_Persona AND 
                                                   dbo.cp_orden_pago.IdPersona = dbo.vwtb_persona_beneficiario.IdPersona AND dbo.cp_orden_pago.IdEntidad = dbo.vwtb_persona_beneficiario.IdEntidad AND 
                                                   A.IdCtaCble = dbo.vwtb_persona_beneficiario.IdCtaCble
                          WHERE        (A.dc_Valor < 0) AND (dbo.cp_orden_pago.IdTipo_op <> 'FACT_PROVEE')) AS Querry
GROUP BY IdEmpresa, IdTipoCbte, IdCbteCble



CREATE view [dbo].[vwct_cbtecble_con_ctacble_acreedora] as
select Querry.IdEmpresa,Querry.IdTipoCbte,Querry.IdCbteCble,max(Querry.IdCtaCble_Acreedora) as IdCtaCble_Acreedora
from 
(
			
				SELECT        cbte_d.IdEmpresa, cbte_d.IdTipoCbte, cbte_d.IdCbteCble, cbte_d.IdCtaCble AS IdCtaCble_Acreedora
				FROM            ct_cbtecble_det AS cbte_d INNER JOIN
						cp_orden_giro AS OG ON cbte_d.IdEmpresa = OG.IdEmpresa AND cbte_d.IdTipoCbte = OG.IdTipoCbte_Ogiro AND cbte_d.IdCbteCble = OG.IdCbteCble_Ogiro
				WHERE        (cbte_d.dc_Valor < 0)
				and exists
				(	
						select cl_pr.IdEmpresa
						from cp_proveedor_clase cl_pr
						where cl_pr.IdEmpresa=cbte_d.IdEmpresa
						and cl_pr.IdCtaCble_CXP=cbte_d.IdCtaCble
				)

				union all

				SELECT  cbte_d.IdEmpresa, cbte_d.IdTipoCbte, cbte_d.IdCbteCble, cbte_d.IdCtaCble AS IdCtaCble_Acreedora
				FROM            cp_nota_DebCre INNER JOIN
							ct_cbtecble_det AS cbte_d ON cp_nota_DebCre.IdEmpresa = cbte_d.IdEmpresa AND cp_nota_DebCre.IdTipoCbte_Nota = cbte_d.IdTipoCbte AND 
							cp_nota_DebCre.IdCbteCble_Nota = cbte_d.IdCbteCble
				WHERE        (cbte_d.dc_Valor < 0) AND (cp_nota_DebCre.DebCre = 'D')
				and exists
				(	
						select cl_pr.IdEmpresa
						from cp_proveedor_clase cl_pr
						where cl_pr.IdEmpresa=cbte_d.IdEmpresa
						and cl_pr.IdCtaCble_CXP=cbte_d.IdCtaCble
				)

				
				union all

				SELECT        A.IdEmpresa, A.IdTipoCbte, A.IdCbteCble, A.IdCtaCble AS IdCtaCble_Acreedora
				FROM            cp_orden_pago_det INNER JOIN
							cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
							ct_cbtecble_det AS A ON cp_orden_pago_det.IdEmpresa_cxp = A.IdEmpresa AND cp_orden_pago_det.IdTipoCbte_cxp = A.IdTipoCbte AND 
							cp_orden_pago_det.IdCbteCble_cxp = A.IdCbteCble INNER JOIN
							vwtb_persona_beneficiario ON cp_orden_pago.IdEmpresa = vwtb_persona_beneficiario.IdEmpresa AND 
							cp_orden_pago.IdTipo_Persona = vwtb_persona_beneficiario.IdTipo_Persona AND cp_orden_pago.IdPersona = vwtb_persona_beneficiario.IdPersona AND 
							cp_orden_pago.IdEntidad = vwtb_persona_beneficiario.IdEntidad AND A.IdCtaCble = vwtb_persona_beneficiario.IdCtaCble
				WHERE        (A.dc_Valor < 0) 
				AND (cp_orden_pago.IdTipo_op <> 'FACT_PROVEE')
				
				union all
				

				select A.IdEmpresa,A.IdTipoCbte,A.IdCbteCble,max(A.IdCtaCble_Acreedora) as IdCtaCble_Acreedora
				from 
					(
							SELECT       det_cbte_cble.IdEmpresa, det_cbte_cble.IdTipoCbte, det_cbte_cble.IdCbteCble,det_cbte_cble.IdCtaCble as IdCtaCble_Acreedora
							FROM            ct_cbtecble_det det_cbte_cble
							WHERE        (dc_Valor < 0)
							and not exists
							(
								select og.IdEmpresa 
								from cp_orden_giro OG
								where OG.IdEmpresa=det_cbte_cble.IdEmpresa
								and OG.IdTipoCbte_Ogiro=det_cbte_cble.IdTipoCbte
								and OG.IdCbteCble_Ogiro=det_cbte_cble.IdCbteCble
							)
							and not exists
							(
								select ND.IdEmpresa 
								from cp_nota_DebCre ND
								where ND.IdEmpresa=det_cbte_cble.IdEmpresa
								and ND.IdTipoCbte_Nota=det_cbte_cble.IdTipoCbte
								and ND.IdCbteCble_Nota=det_cbte_cble.IdCbteCble
							)
							and not exists
							(

								select Diarios_x_OP.IdEmpresa
								from
								(
										SELECT        cp_orden_pago_det.*
										FROM            cp_orden_pago_det INNER JOIN
											cp_orden_pago ON cp_orden_pago_det.IdEmpresa = cp_orden_pago.IdEmpresa AND cp_orden_pago_det.IdOrdenPago = cp_orden_pago.IdOrdenPago INNER JOIN
											ct_cbtecble_det AS A ON cp_orden_pago_det.IdEmpresa_cxp = A.IdEmpresa AND cp_orden_pago_det.IdTipoCbte_cxp = A.IdTipoCbte AND 
											cp_orden_pago_det.IdCbteCble_cxp = A.IdCbteCble INNER JOIN
											vwtb_persona_beneficiario ON cp_orden_pago.IdEmpresa = vwtb_persona_beneficiario.IdEmpresa AND 
											cp_orden_pago.IdTipo_Persona = vwtb_persona_beneficiario.IdTipo_Persona AND cp_orden_pago.IdPersona = vwtb_persona_beneficiario.IdPersona AND 
											cp_orden_pago.IdEntidad = vwtb_persona_beneficiario.IdEntidad AND A.IdCtaCble = vwtb_persona_beneficiario.IdCtaCble
										WHERE        (A.dc_Valor < 0) 
										AND (cp_orden_pago.IdTipo_op <> 'FACT_PROVEE')
								) as Diarios_x_OP
								where Diarios_x_OP.IdEmpresa=det_cbte_cble.IdEmpresa
								and Diarios_x_OP.IdTipoCbte_cxp=det_cbte_cble.IdTipoCbte
								and Diarios_x_OP.IdCbteCble_cxp=det_cbte_cble.IdCbteCble


							)

							
					) as A  
				group by A.IdEmpresa,A.IdTipoCbte,A.IdCbteCble

) as Querry
group by Querry.IdEmpresa,Querry.IdTipoCbte,Querry.IdCbteCble
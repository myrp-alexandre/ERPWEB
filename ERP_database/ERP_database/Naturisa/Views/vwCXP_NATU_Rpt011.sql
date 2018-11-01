CREATE view [Naturisa].[vwCXP_NATU_Rpt011]
as
/*OG*/ SELECT ISNULL(ROW_NUMBER() OVER (ORDER BY A.IdEmpresa), 0) AS IdRow, A.*
FROM            (  SELECT        (CASE WHEN b.dc_Valor >= 0 THEN b.dc_Valor ELSE 0 END) AS debe, (CASE WHEN b.dc_Valor <= 0 THEN b.dc_Valor * - 1 ELSE 0 END) AS Cred, 
 a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.CodCbteCble, a.IdPeriodo, a.cb_Fecha, a.cb_Valor, a.cb_Observacion, a.cb_Estado, a.cb_Anio, a.cb_mes, b.secuencia, 
                         b.IdCtaCble, b.dc_Valor, b.dc_Observacion, c.pc_Cuenta, ct_cbtecble_tipo.tc_TipoCbte, ct_punto_cargo_grupo.nom_punto_cargo_grupo, 
                         ct_punto_cargo.nom_punto_cargo, c.pc_clave_corta, cp_orden_giro.IdProveedor, cp_proveedor.pr_codigo, tb_persona.pe_nombreCompleto
FROM            cp_proveedor INNER JOIN
                         ct_cbtecble AS a INNER JOIN
                         ct_cbtecble_det AS b ON a.IdEmpresa = b.IdEmpresa AND a.IdTipoCbte = b.IdTipoCbte AND a.IdCbteCble = b.IdCbteCble INNER JOIN
                         ct_plancta AS c ON b.IdCtaCble = c.IdCtaCble AND b.IdEmpresa = c.IdEmpresa INNER JOIN
                         cp_orden_giro ON a.IdEmpresa = cp_orden_giro.IdEmpresa AND a.IdTipoCbte = cp_orden_giro.IdTipoCbte_Ogiro AND 
                         a.IdCbteCble = cp_orden_giro.IdCbteCble_Ogiro ON cp_proveedor.IdEmpresa = cp_orden_giro.IdEmpresa AND 
                         cp_proveedor.IdProveedor = cp_orden_giro.IdProveedor INNER JOIN
                         tb_persona ON cp_proveedor.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
                         ct_cbtecble_tipo ON a.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte AND a.IdEmpresa = ct_cbtecble_tipo.IdEmpresa LEFT OUTER JOIN
                         ct_punto_cargo INNER JOIN
                         ct_punto_cargo_grupo ON ct_punto_cargo.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
                         ct_punto_cargo.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo ON b.IdPunto_cargo_grupo = ct_punto_cargo.IdPunto_cargo_grupo AND 
                         b.IdEmpresa = ct_punto_cargo.IdEmpresa AND b.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo
                          UNION
                          /*ND/NC*/ 
							SELECT        (CASE WHEN b.dc_Valor >= 0 THEN b.dc_Valor ELSE 0 END) AS debe, (CASE WHEN b.dc_Valor <= 0 THEN b.dc_Valor * - 1 ELSE 0 END) AS Cred, 
							a.IdEmpresa, a.IdTipoCbte, a.IdCbteCble, a.CodCbteCble, a.IdPeriodo, a.cb_Fecha, a.cb_Valor, a.cb_Observacion, a.cb_Estado, a.cb_Anio, a.cb_mes, b.secuencia, 
							b.IdCtaCble, b.dc_Valor, b.dc_Observacion, c.pc_Cuenta, ct_cbtecble_tipo.tc_TipoCbte, ct_punto_cargo_grupo.nom_punto_cargo_grupo, 
							ct_punto_cargo.nom_punto_cargo, c.pc_clave_corta, cp_nota_DebCre.IdProveedor, cp_proveedor.pr_codigo, tb_persona.pe_nombreCompleto
							FROM            cp_proveedor INNER JOIN
							ct_cbtecble AS a INNER JOIN
							ct_cbtecble_det AS b ON a.IdEmpresa = b.IdEmpresa AND a.IdTipoCbte = b.IdTipoCbte AND a.IdCbteCble = b.IdCbteCble INNER JOIN
							ct_plancta AS c ON b.IdCtaCble = c.IdCtaCble AND b.IdEmpresa = c.IdEmpresa INNER JOIN
							cp_nota_DebCre ON a.IdEmpresa = cp_nota_DebCre.IdEmpresa AND a.IdTipoCbte = cp_nota_DebCre.IdTipoCbte_Nota AND 
							a.IdCbteCble = cp_nota_DebCre.IdCbteCble_Nota ON cp_proveedor.IdEmpresa = cp_nota_DebCre.IdEmpresa AND 
							cp_proveedor.IdProveedor = cp_nota_DebCre.IdProveedor INNER JOIN
							tb_persona ON cp_proveedor.IdPersona = tb_persona.IdPersona LEFT OUTER JOIN
							ct_cbtecble_tipo ON a.IdTipoCbte = ct_cbtecble_tipo.IdTipoCbte AND a.IdEmpresa = ct_cbtecble_tipo.IdEmpresa LEFT OUTER JOIN
							ct_punto_cargo INNER JOIN
							ct_punto_cargo_grupo ON ct_punto_cargo.IdEmpresa = ct_punto_cargo_grupo.IdEmpresa AND 
							ct_punto_cargo.IdPunto_cargo_grupo = ct_punto_cargo_grupo.IdPunto_cargo_grupo ON b.IdPunto_cargo_grupo = ct_punto_cargo.IdPunto_cargo_grupo AND 
							b.IdEmpresa = ct_punto_cargo.IdEmpresa AND b.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo) A
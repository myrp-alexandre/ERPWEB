-- querry reporte para cheques girados y no conciliados
CREATE VIEW [dbo].[vwBAN_Rpt016]
AS
SELECT        dbo.ba_Cbte_Ban.IdEmpresa, dbo.ba_Cbte_Ban.IdCbteCble, dbo.ba_Cbte_Ban.IdTipocbte, dbo.ba_Cbte_Ban.Cod_Cbtecble, dbo.ba_Cbte_Ban.IdPeriodo, 
                         dbo.ba_Cbte_Ban.IdBanco, IdEntidad IdProveedor, dbo.ba_Cbte_Ban.cb_Fecha, dbo.ba_Cbte_Ban.cb_Observacion, 0 cb_secuencia, 
                         dbo.ba_Cbte_Ban.cb_Valor, dbo.ba_Cbte_Ban.cb_Cheque, 'S' cb_ChequeImpreso, getdate() cb_FechaCheque, dbo.ba_Cbte_Ban.IdUsuario, 
                         dbo.ba_Cbte_Ban.IdUsuario_Anu, dbo.ba_Cbte_Ban.FechaAnulacion, dbo.ba_Cbte_Ban.Fecha_Transac, dbo.ba_Cbte_Ban.Fecha_UltMod, 
                         dbo.ba_Cbte_Ban.IdUsuarioUltMod, dbo.ba_Cbte_Ban.Estado, dbo.ba_Cbte_Ban.MotivoAnulacion, '' ip, '' nom_pc, 
                         ISNULL(dbo.ba_Cbte_Ban.IdPersona_Girado_a, 0) AS IdPersona_Girado_a, dbo.ba_Cbte_Ban.cb_giradoA, dbo.ba_Cbte_Ban.cb_ciudadChq, 
                         NULL IdCbteCble_Anulacion, NULL IdTipoCbte_Anulacion, dbo.ba_Cbte_Ban.IdTipoFlujo, dbo.ba_Cbte_Ban.IdTipoNota, 
                         0 IdTransaccion, 'N' Por_Anticipo, 'N' PosFechado, dbo.ba_Cbte_Ban.ValorEnLetras, dbo.ba_Cbte_Ban.IdSucursal, 
                         CASE isnull(a.checked, 0) WHEN 1 THEN 'Conciliado' WHEN 0 THEN 'No Conciliado' END AS Tipo_Conciliacion, dbo.tb_banco.ba_descripcion
FROM            dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo INNER JOIN
                         dbo.ba_Cbte_Ban_tipo ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan = dbo.ba_Cbte_Ban_tipo.CodTipoCbteBan INNER JOIN
                         dbo.ba_Cbte_Ban ON dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa = dbo.ba_Cbte_Ban.IdEmpresa AND 
                         dbo.ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble = dbo.ba_Cbte_Ban.IdTipocbte LEFT OUTER JOIN
                         dbo.tb_banco ON dbo.ba_Cbte_Ban.IdBanco = dbo.tb_banco.IdBanco LEFT OUTER JOIN
                             (SELECT DISTINCT IdEmpresa, IdCbteCble, IdTipocbte, SecuenciaCbteCble, checked, Estado
                               FROM            dbo.ba_Conciliacion_det_IngEgr
                               WHERE        (Estado = 'A') AND (checked = 1)) AS a ON dbo.ba_Cbte_Ban.IdEmpresa = a.IdEmpresa AND dbo.ba_Cbte_Ban.IdTipocbte = a.IdTipocbte AND 
                         dbo.ba_Cbte_Ban.IdCbteCble = a.IdCbteCble
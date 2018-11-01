CREATE view [dbo].[vwin_Ajuste_fisico_x_relacion_inven_x_cbteCble] as
SELECT     A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.cm_observacion, A.cm_fecha,  Cbte.IdTipoCbte, Cbte.IdCbteCble, 
                      Cbte.CodCbteCble, Cbte.cb_Fecha, Cbte.cb_Valor, Cbte.cb_Observacion, AjFis.IdAjusteFisico, Sucu.Su_Descripcion, MoviT.tm_descripcion, 
                      TipCb.tc_TipoCbte
FROM         tb_sucursal AS Sucu INNER JOIN
                      in_ajusteFisico AS AjFis INNER JOIN
                      in_movi_inve AS A ON AjFis.IdEmpresa = A.IdEmpresa AND AjFis.IdSucursal = A.IdSucursal AND AjFis.IdBodega = A.IdBodega AND 
                      AjFis.IdMovi_inven_tipo_Ing = A.IdMovi_inven_tipo AND AjFis.IdNumMovi_Ing = A.IdNumMovi ON Sucu.IdEmpresa = A.IdEmpresa AND 
                      Sucu.IdSucursal = A.IdSucursal INNER JOIN
                      in_movi_inven_tipo AS MoviT ON A.IdEmpresa = MoviT.IdEmpresa AND A.IdMovi_inven_tipo = MoviT.IdMovi_inven_tipo LEFT OUTER JOIN
                      ct_cbtecble_tipo AS TipCb INNER JOIN
                      ct_cbtecble AS Cbte INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS B ON Cbte.IdEmpresa = B.IdEmpresa AND Cbte.IdTipoCbte = B.IdTipoCbte AND Cbte.IdCbteCble = B.IdCbteCble ON 
                      TipCb.IdTipoCbte = Cbte.IdTipoCbte ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
                      A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi
union 
SELECT     A.IdEmpresa, A.IdSucursal, A.IdBodega, A.IdMovi_inven_tipo, A.IdNumMovi, A.cm_observacion, A.cm_fecha,  Cbte.IdTipoCbte, Cbte.IdCbteCble, 
                      Cbte.CodCbteCble, Cbte.cb_Fecha, Cbte.cb_Valor, Cbte.cb_Observacion, AjFis.IdAjusteFisico, Sucu.Su_Descripcion, MoviT.tm_descripcion, 
                      TipCb.tc_TipoCbte
FROM         tb_sucursal AS Sucu INNER JOIN
                      in_ajusteFisico AS AjFis INNER JOIN
                      in_movi_inve AS A ON AjFis.IdEmpresa = A.IdEmpresa AND AjFis.IdSucursal = A.IdSucursal AND AjFis.IdBodega = A.IdBodega AND 
                      AjFis.IdMovi_inven_tipo_Egr = A.IdMovi_inven_tipo AND AjFis.IdNumMovi_Egr = A.IdNumMovi ON Sucu.IdEmpresa = A.IdEmpresa AND 
                      Sucu.IdSucursal = A.IdSucursal INNER JOIN
                      in_movi_inven_tipo AS MoviT ON A.IdEmpresa = MoviT.IdEmpresa AND A.IdMovi_inven_tipo = MoviT.IdMovi_inven_tipo LEFT OUTER JOIN
                      ct_cbtecble_tipo AS TipCb INNER JOIN
                      ct_cbtecble AS Cbte INNER JOIN
                      in_movi_inve_x_ct_cbteCble AS B ON Cbte.IdEmpresa = B.IdEmpresa AND Cbte.IdTipoCbte = B.IdTipoCbte AND Cbte.IdCbteCble = B.IdCbteCble ON 
                      TipCb.IdTipoCbte = Cbte.IdTipoCbte ON A.IdEmpresa = B.IdEmpresa AND A.IdSucursal = B.IdSucursal AND A.IdBodega = B.IdBodega AND 
                      A.IdMovi_inven_tipo = B.IdMovi_inven_tipo AND A.IdNumMovi = B.IdNumMovi
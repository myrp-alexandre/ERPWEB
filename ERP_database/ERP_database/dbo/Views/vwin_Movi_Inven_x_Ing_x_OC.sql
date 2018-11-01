CREATE view [dbo].[vwin_Movi_Inven_x_Ing_x_OC]
as
SELECT     MoviIn.IdEmpresa, Sucu.Su_Descripcion, Bod.bo_Descripcion, TipoMovi_Inv.tm_descripcion as Tipo_Movi_Inven, 
MoviIn.IdNumMovi, MoviIn.cm_observacion, MoviIn.cm_fecha, 
                      SucuOC.Su_Descripcion AS Sucursal_OC, OC.IdOrdenCompra, OC.oc_fecha, OC.oc_observacion, MoviIn.IdSucursal, MoviIn.IdBodega,
                       MoviIn.IdMovi_inven_tipo, 
                      Prov.IdProveedor, Prov.pr_codigo, pe_nombreCompleto pr_nombre
                      ,MoviIn.Estado
FROM         in_movi_inve AS MoviIn INNER JOIN
                      in_movi_inven_tipo AS TipoMovi_Inv ON MoviIn.IdEmpresa = TipoMovi_Inv.IdEmpresa AND MoviIn.IdMovi_inven_tipo = TipoMovi_Inv.IdMovi_inven_tipo INNER JOIN
                      in_movi_inve_x_in_ordencompra_local AS MoviInven_OC ON MoviIn.IdEmpresa = MoviInven_OC.IdEmpresa AND MoviIn.IdSucursal = MoviInven_OC.IdSucursal AND 
                      MoviIn.IdBodega = MoviInven_OC.IdBodega AND MoviIn.IdMovi_inven_tipo = MoviInven_OC.IdMovi_inven_tipo AND 
                      MoviIn.IdNumMovi = MoviInven_OC.IdNumMovi INNER JOIN
                      com_ordencompra_local AS OC ON MoviInven_OC.IdEmpresaOC = OC.IdEmpresa AND MoviInven_OC.IdSucursalOC = OC.IdSucursal AND 
                      MoviInven_OC.IdOrdenCompra = OC.IdOrdenCompra INNER JOIN
                      tb_bodega AS Bod ON MoviIn.IdEmpresa = Bod.IdEmpresa AND MoviIn.IdSucursal = Bod.IdSucursal AND MoviIn.IdBodega = Bod.IdBodega INNER JOIN
                      tb_sucursal AS Sucu ON Bod.IdEmpresa = Sucu.IdEmpresa AND Bod.IdSucursal = Sucu.IdSucursal INNER JOIN
                      cp_proveedor AS Prov ON OC.IdEmpresa = Prov.IdEmpresa AND OC.IdProveedor = Prov.IdProveedor INNER JOIN
                      tb_sucursal AS SucuOC ON OC.IdEmpresa = SucuOC.IdEmpresa AND OC.IdSucursal = SucuOC.IdSucursal
					  inner join tb_persona as per on per.IdPersona = prov.IdPersona
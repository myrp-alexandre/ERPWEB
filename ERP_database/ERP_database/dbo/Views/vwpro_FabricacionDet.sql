create view vwpro_FabricacionDet
as
SELECT        pro_FabricacionDet.IdEmpresa, pro_FabricacionDet.IdFabricacion, pro_FabricacionDet.Secuencia, pro_FabricacionDet.Signo, pro_FabricacionDet.IdProducto, pro_FabricacionDet.IdUnidadMedida, pro_FabricacionDet.Cantidad, 
                         pro_FabricacionDet.Costo, pro_FabricacionDet.RealizaMovimiento, in_Producto.pr_descripcion
FROM            pro_FabricacionDet LEFT OUTER JOIN
                         in_Producto ON pro_FabricacionDet.IdEmpresa = in_Producto.IdEmpresa AND pro_FabricacionDet.IdProducto = in_Producto.IdProducto
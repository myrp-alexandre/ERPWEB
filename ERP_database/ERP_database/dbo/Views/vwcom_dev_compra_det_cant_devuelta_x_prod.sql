
create view [dbo].[vwcom_dev_compra_det_cant_devuelta_x_prod]
as
SELECT     ocdet_IdEmpresa, ocdet_IdSucursal, ocdet_IdOrdenCompra, ocdet_Secuencia, IdProducto, SUM(dv_Cantidad) AS cant_devuelta
FROM         com_dev_compra_det
GROUP BY ocdet_IdEmpresa, ocdet_IdSucursal, ocdet_IdOrdenCompra, ocdet_Secuencia, IdProducto
CREATE view vwcom_ordencompra_local_vs_in_Guia_x_traspaso_bodega_Total_Reg
as
select com_ordencompra_local_det.IdEmpresa,com_ordencompra_local_det.IdSucursal,com_ordencompra_local_det.IdOrdenCompra, 
count(com_ordencompra_local_det.IdEmpresa) as Total_reg_x_OC,count(in_Guia_x_traspaso_bodega_det.IdEmpresa_OC) Total_reg_x_Guia
FROM            in_Guia_x_traspaso_bodega_det RIGHT OUTER JOIN
                         com_ordencompra_local_det ON in_Guia_x_traspaso_bodega_det.IdEmpresa_OC = com_ordencompra_local_det.IdEmpresa AND 
                         in_Guia_x_traspaso_bodega_det.IdSucursal_OC = com_ordencompra_local_det.IdSucursal AND 
                         in_Guia_x_traspaso_bodega_det.IdOrdenCompra_OC = com_ordencompra_local_det.IdOrdenCompra AND 
                         in_Guia_x_traspaso_bodega_det.Secuencia_OC = com_ordencompra_local_det.Secuencia
						 group  by com_ordencompra_local_det.IdEmpresa,com_ordencompra_local_det.IdSucursal,com_ordencompra_local_det.IdOrdenCompra
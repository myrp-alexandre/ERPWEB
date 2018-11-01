
--select * from com_ordencompra_local_det_x_com_solicitud_compra_det
--select * from vwcom_ordencompra_local_det_x_com_solicitud_compra_det

--drop view vwcom_solicitud_compra_det_con_datos_OC

create view [dbo].[vwcom_solicitud_compra_det_x_Orden_Compra]
as
select distinct A.scd_IdEmpresa,A.scd_IdSolicitudCompra,A.scd_IdSucursal,A.scd_Secuencia,A.ocd_IdEmpresa,A.ocd_IdSucursal, A.ocd_IdOrdenCompra
from com_ordencompra_local_det_x_com_solicitud_compra_det A
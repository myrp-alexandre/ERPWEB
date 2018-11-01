CREATE proc [dbo].[spSys_Borrar_Orden_Pago] as
delete from cp_orden_pago
delete from cp_orden_pago_det 
delete cp_orden_pago_cancelacion
delete cp_Aprobacion_Orden_pago
delete cp_Aprobacion_Orden_pago_det
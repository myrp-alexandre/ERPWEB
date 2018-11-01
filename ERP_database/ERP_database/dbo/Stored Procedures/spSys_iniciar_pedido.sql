create proc [dbo].[spSys_iniciar_pedido]
as

select * from fa_factura_x_fa_guia_remision
select * from fa_guia_remision_det_x_fa_orden_Desp_det
select * from fa_guia_remision_det
select * from fa_guia_remision

select * from fa_orden_Desp_det_x_fa_pedido_det
select * from fa_orden_Desp_det
select * from fa_orden_Desp

select * from fa_pedido_x_fa_orden_Desp_det_x_fa_guia_remision_det



delete fa_factura_x_fa_guia_remision
delete from fa_guia_remision_det_x_fa_orden_Desp_det
delete from fa_guia_remision_det
delete from fa_guia_remision
delete from fa_orden_Desp_det_x_fa_pedido_det
delete from fa_orden_Desp_det
delete from fa_orden_Desp
delete from fa_pedido_x_formaPago
delete from fa_pedido_det
delete from fa_pedido
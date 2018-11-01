CREATE proc [dbo].[spSys_verificador_flujo_compras]
(
@i_idempresa int
,@i_idsucursal int
,@i_idsolicitud numeric
)
as

/*
declare @i_idempresa int
set @i_idempresa =15
*/




select 'cab solicitud_compra'
select *from dbo.com_solicitud_compra
where IdEmpresa=@i_idempresa
and IdSucursal =@i_idsucursal
and IdSolicitudCompra=@i_idsolicitud


select 'det solicitud_compra'
select * from dbo.com_solicitud_compra_det
where IdEmpresa=@i_idempresa
and IdSucursal =@i_idsucursal
and IdSolicitudCompra=@i_idsolicitud




select 'Aprob solicitud_compra'
select * from dbo.com_solicitud_compra_det_aprobacion
where IdEmpresa=@i_idempresa
and IdSucursal_SC =@i_idsucursal
and IdSolicitudCompra=@i_idsolicitud




select 'relacion OC vs SC'
select * from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
where ocd_IdEmpresa=@i_idempresa
and scd_IdSucursal=@i_idsucursal
and scd_IdSolicitudCompra=@i_idsolicitud



select 'cab OC'
select * from dbo.com_ordencompra_local A
where 
(cast(A.IdEmpresa  as varchar(20))+ '-'+cast(A.IdSucursal as varchar(20))+'-'+ cast(A.IdOrdenCompra as varchar(20)))  in
(
	select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+ '-'+ cast(ocd_IdOrdenCompra as varchar(20))
	from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
	where ocd_IdEmpresa=@i_idempresa
	and scd_IdSucursal=@i_idsucursal
	and scd_IdSolicitudCompra=@i_idsolicitud
)



select 'det  OC'
select * from dbo.com_ordencompra_local_det A
where 
(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+'-'+ cast(A.IdOrdenCompra as varchar(20)))  in
(
	select CAST(ocd_IdEmpresa as varchar(20))+ '-'+cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
	from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
	where ocd_IdEmpresa=@i_idempresa
	and scd_IdSucursal=@i_idsucursal
	and scd_IdSolicitudCompra=@i_idsolicitud
)



select 'cab ING x  OC'
select * from dbo.in_Ingreso_x_OrdenCompra A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdIngreso_x_oc as varchar(20))
in (
	
	select cast(B.IdEmpresa as varchar(20)) + '-'+ cast(B.IdIngreso_x_oc  as varchar(20)) 
	from dbo.in_Ingreso_x_OrdenCompra_det B
	where 
	(cast(B.IdEmpresa_oc as varchar(20)) + '-'+ cast(B.IdSucursal_oc as varchar(20)) +'-'+ cast(B.IdOrdenCompra as varchar(20)))
	in 
	(

			select cast(A.IdEmpresa  as varchar(20))+ '-' +cast(A.IdSucursal as varchar(20))+ '-'+ cast(A.IdOrdenCompra as varchar(20)) 
			from dbo.com_ordencompra_local A
			where 
			(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+ '-'+cast(A.IdOrdenCompra as varchar(20)))  in
			(
				select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
				from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
				where ocd_IdEmpresa=@i_idempresa
				and scd_IdSucursal=@i_idsucursal
				and scd_IdSolicitudCompra=@i_idsolicitud
			)
	)
)



select 'det ING x  OC'
	select * 
	from dbo.in_Ingreso_x_OrdenCompra_det B
	where 
	(cast(B.IdEmpresa_oc as varchar(20)) + '-'+ cast(B.IdSucursal_oc as varchar(20)) +'-'+ cast(B.IdOrdenCompra as varchar(20)))
	in 
	(

			select cast(A.IdEmpresa  as varchar(20))+ '-' +cast(A.IdSucursal as varchar(20))+ '-'+ cast(A.IdOrdenCompra as varchar(20)) 
			from dbo.com_ordencompra_local A
			where 
			(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+ '-'+cast(A.IdOrdenCompra as varchar(20)))  in
			(
				select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
				from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
				where ocd_IdEmpresa=@i_idempresa
				and scd_IdSucursal=@i_idsucursal
				and scd_IdSolicitudCompra=@i_idsolicitud
			)
	)



select * 
from dbo.in_movi_inve_detalle_x_com_ordencompra_local_det C
where cast(C.ocd_IdEmpresa  as varchar(20))+ '-' + cast(C.ocd_IdSucursal  as varchar(20))+ '-'+CAST( C.ocd_IdOrdenCompra as varchar(20))
in 
(

			select cast(A.IdEmpresa  as varchar(20))+ '-' +cast(A.IdSucursal as varchar(20))+ '-'+ cast(A.IdOrdenCompra as varchar(20)) 
			from dbo.com_ordencompra_local A
			where 
			(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+ '-'+cast(A.IdOrdenCompra as varchar(20)))  in
			(
				select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
				from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
				where ocd_IdEmpresa=@i_idempresa
				and scd_IdSucursal=@i_idsucursal
				and scd_IdSolicitudCompra=@i_idsolicitud
			)
)			



select * from in_movi_inve A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdSucursal as varchar(20)) + cast(A.IdBodega as varchar(20)) 
+ cast(A.IdMovi_inven_tipo as varchar(20))+  cast(A.IdNumMovi as varchar(20))
in
(
	select cast(c.mi_IdEmpresa as varchar(20)) + cast(c.mi_IdSucursal as varchar(20)) + cast(c.mi_IdBodega as varchar(20)) 
	+ cast(c.mi_IdMovi_inven_tipo as varchar(20))  + cast(c.mi_IdNumMovi as varchar(20))
	from dbo.in_movi_inve_detalle_x_com_ordencompra_local_det C
	where cast(C.ocd_IdEmpresa  as varchar(20))+ '-' + cast(C.ocd_IdSucursal  as varchar(20))+ '-'+CAST( C.ocd_IdOrdenCompra as varchar(20))
	in 
	(

				select cast(A.IdEmpresa  as varchar(20))+ '-' +cast(A.IdSucursal as varchar(20))+ '-'+ cast(A.IdOrdenCompra as varchar(20)) 
				from dbo.com_ordencompra_local A
				where 
				(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+ '-'+cast(A.IdOrdenCompra as varchar(20)))  in
				(
					select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
					from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
					where ocd_IdEmpresa=@i_idempresa
					and scd_IdSucursal=@i_idsucursal
					and scd_IdSolicitudCompra=@i_idsolicitud
				)
	)			

)



select * from in_movi_inve_detalle A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdSucursal as varchar(20)) + cast(A.IdBodega as varchar(20)) 
+ cast(A.IdMovi_inven_tipo as varchar(20))+  cast(A.IdNumMovi as varchar(20))
in
(
	select cast(c.mi_IdEmpresa as varchar(20)) + cast(c.mi_IdSucursal as varchar(20)) + cast(c.mi_IdBodega as varchar(20)) 
	+ cast(c.mi_IdMovi_inven_tipo as varchar(20))  + cast(c.mi_IdNumMovi as varchar(20))
	from dbo.in_movi_inve_detalle_x_com_ordencompra_local_det C
	where cast(C.ocd_IdEmpresa  as varchar(20))+ '-' + cast(C.ocd_IdSucursal  as varchar(20))+ '-'+CAST( C.ocd_IdOrdenCompra as varchar(20))
	in 
	(

				select cast(A.IdEmpresa  as varchar(20))+ '-' +cast(A.IdSucursal as varchar(20))+ '-'+ cast(A.IdOrdenCompra as varchar(20)) 
				from dbo.com_ordencompra_local A
				where 
				(cast(A.IdEmpresa  as varchar(20))+ '-'+ cast(A.IdSucursal as varchar(20))+ '-'+cast(A.IdOrdenCompra as varchar(20)))  in
				(
					select CAST(ocd_IdEmpresa as varchar(20))+'-'+ cast(ocd_IdSucursal as varchar(20))+'-'+ cast(ocd_IdOrdenCompra as varchar(20))
					from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
					where ocd_IdEmpresa=@i_idempresa
					and scd_IdSucursal=@i_idsucursal
					and scd_IdSolicitudCompra=@i_idsolicitud
				)
	)			

)




/*
delete from dbo.com_ordencompra_local_det_x_com_solicitud_compra_det
where ocd_IdEmpresa=@i_idempresa


delete from dbo.com_solicitud_compra_det_aprobacion
where IdEmpresa=@i_idempresa


delete from dbo.com_solicitud_compra_det
where IdEmpresa=@i_idempresa


delete from dbo.com_solicitud_compra
where IdEmpresa=@i_idempresa


delete dbo.in_movi_inve_detalle_x_com_ordencompra_local_det
where  mi_IdEmpresa =@i_idempresa

delete dbo.in_Ingreso_x_OrdenCompra_det  where IdEmpresa=@i_idempresa
delete dbo.in_Ingreso_x_OrdenCompra where IdEmpresa=@i_idempresa



delete from dbo.com_ordencompra_local_det where IdEmpresa=@i_idempresa
delete from dbo.com_ordencompra_local where IdEmpresa=@i_idempresa




select * from dbo.com_ordencompra_local
where IdEmpresa=@i_idempresa
select * from dbo.com_ordencompra_local_det 
where IdEmpresa=@i_idempresa

*/
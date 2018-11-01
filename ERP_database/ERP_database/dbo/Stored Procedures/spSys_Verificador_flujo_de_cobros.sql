-- exec spSys_Verificador_flujo_de_cobros 1,1,50


CREATE proc [dbo].[spSys_Verificador_flujo_de_cobros]
(
 @i_idempresa as numeric
,@i_idsucursal as numeric
,@i_idCobro as numeric
)
as


/*
declare @i_idAnticipo as numeric
declare @i_idempresa as numeric
set @i_idAnticipo =3
set @i_idempresa =1
*/


select '===== tipo cobro  ========================'


select *
from cxc_cobro_tipo  A
where IdCobro_tipo in
(
	select IdCobro_tipo 
	from cxc_cobro A
	where A.IdEmpresa = @i_idempresa
	and A.IdSucursal =@i_idsucursal
	and A.IdCobro  =@i_idCobro
)


select '===== cabecera cobro  ========================'
select *
from cxc_cobro A
where A.IdEmpresa = @i_idempresa
and A.IdSucursal =@i_idsucursal
and A.IdCobro  =@i_idCobro


select '===== detalle cobro  ========================'
select *
from cxc_cobro_det  A
where A.IdEmpresa = @i_idempresa
and A.IdSucursal =@i_idsucursal
and A.IdCobro  =@i_idCobro

	

select '==== estado cobro  ========================'

select * 
from cxc_cobro_x_EstadoCobro 	A
where A.IdEmpresa = @i_idempresa
and A.IdSucursal =@i_idsucursal
and A.IdCobro  =@i_idCobro


select '==== cobro x caja movimiento tabla intermedia ========================'	



select * 
from cxc_cobro_x_caj_Caja_Movimiento	A
where A.cbr_IdEmpresa = @i_idempresa
and A.cbr_IdSucursal =@i_idsucursal
and A.cbr_IdCobro  =@i_idCobro


select '====== cabecera caja movimiento  ========================'	

select * 
from caj_Caja_Movimiento A
where cast(A.IdEmpresa as varchar(20)) + '-'+cast(A.IdTipocbte  as varchar(20)) +'-'+ cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.mcj_IdEmpresa as varchar(20)) + '-'+cast(A.mcj_IdTipocbte as varchar(20)) + '-'+cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where A.cbr_IdEmpresa = @i_idempresa
		and A.cbr_IdSucursal =@i_idsucursal
		and A.cbr_IdCobro  =@i_idCobro
	)


select '====== detalle caja movimiento  ========================'	

select * 
from caj_Caja_Movimiento_det  A
where cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdTipocbte  as varchar(20)) +'-'+ cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.mcj_IdEmpresa as varchar(20)) +'-'+ cast(A.mcj_IdTipocbte as varchar(20)) + '-'+cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where A.cbr_IdEmpresa = @i_idempresa
		and A.cbr_IdSucursal =@i_idsucursal
		and A.cbr_IdCobro  =@i_idCobro
	)

select '= cabecera comprobante conta x caja movimiento ========================'	

select * 
from ct_cbtecble   A
where cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdTipocbte  as varchar(20)) +'-'+ cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + '-'+cast( A.mcj_IdTipocbte as varchar(20)) + '-'+cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)

select '= det comprobante conta x caja movimiento ========================'	
select * 
from ct_cbtecble_det    A
where cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdTipocbte  as varchar(20)) + '-'+cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + '-'+cast( A.mcj_IdTipocbte as varchar(20)) + '-'+cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)


select '==cabecera comprobante conta solo diario  ========================'	


select * 
from ct_cbtecble   A
where cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdTipocbte  as varchar(20)) + '-'+cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.ct_IdEmpresa as varchar(20)) +'-'+ cast(A.ct_IdTipoCbte as varchar(20)) +'-'+ cast(A.ct_IdCbteCble as varchar(20))
		from  cxc_cobro_x_ct_cbtecble A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)

select '==detalle comprobante conta solo diario  ========================'	
select * 
from ct_cbtecble_det    A
where cast(A.IdEmpresa as varchar(20)) + '-'+cast(A.IdTipocbte  as varchar(20)) +'-'+ cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.ct_IdEmpresa as varchar(20)) + '-'+ cast(A.ct_IdTipoCbte as varchar(20)) + '-' +  cast(A.ct_IdCbteCble as varchar(20))
		from  cxc_cobro_x_ct_cbtecble A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)

select '==cabecera comprobante anulado conta solo diario  ========================'	


select * 
from ct_cbtecble   A
where cast(A.IdEmpresa as varchar(20)) +'-'+ cast(A.IdTipocbte  as varchar(20)) + '-'+cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.ct_IdEmpresa as varchar(20)) +'-'+ cast(A.ct_IdTipoCbte as varchar(20)) +'-'+ cast(A.ct_IdCbteCble as varchar(20))
		from  cxc_cobro_x_ct_cbtecble_x_Anulado A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)

select '==detalle comprobante anulado conta solo diario  ========================'	
select * 
from ct_cbtecble_det    A
where cast(A.IdEmpresa as varchar(20)) + '-'+cast(A.IdTipocbte  as varchar(20)) +'-'+ cast(A.IdCbteCble as varchar(20))
in (
		select cast(A.ct_IdEmpresa as varchar(20)) + '-'+ cast(A.ct_IdTipoCbte as varchar(20)) + '-' +  cast(A.ct_IdCbteCble as varchar(20))
		from  cxc_cobro_x_ct_cbtecble_x_Anulado A
		where A.cbr_IdEmpresa=@i_idempresa
		and A.cbr_IdSucursal=@i_idsucursal
		and A.cbr_IdCobro=@i_idCobro 
	)
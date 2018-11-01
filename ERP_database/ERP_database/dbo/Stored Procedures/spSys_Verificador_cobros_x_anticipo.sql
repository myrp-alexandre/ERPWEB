-- exec spSys_Verificador_cobros_x_anticipo  1 ,3

CREATE proc [dbo].[spSys_Verificador_cobros_x_anticipo] 
(
@i_idempresa as numeric
,@i_idAnticipo as numeric
)
as
/*
declare @i_idAnticipo as numeric
declare @i_idempresa as numeric
set @i_idAnticipo =3
set @i_idempresa =1
*/

select '============================= anticipo ========================'
select * from cxc_cobro_x_Anticipo
where IdEmpresa =@i_idempresa
and IdAnticipo =@i_idAnticipo

select * from cxc_cobro_x_Anticipo_det
where IdEmpresa =@i_idempresa
and IdAnticipo =@i_idAnticipo

select '============================= cobros ========================'

select *
from cxc_cobro A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdSucursal as varchar(20))+ cast(A.IdCobro  as varchar(20))
in (
		select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
		from cxc_cobro_x_Anticipo_det
		where IdEmpresa =@i_idempresa
		and IdAnticipo =@i_idAnticipo
	)



select *
from cxc_cobro_det  A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdSucursal as varchar(20))+ cast(A.IdCobro  as varchar(20))
in (
		select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
		from cxc_cobro_x_Anticipo_det
		where IdEmpresa =@i_idempresa
		and IdAnticipo =@i_idAnticipo
	)
	

select '============================= estado cobro  ========================'

select * 
from cxc_cobro_x_EstadoCobro 	A
where cast(A.IdEmpresa as varchar(20))+ cast(A.IdSucursal as varchar(20))+ cast(A.IdCobro  as varchar(20))
in (
		select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
		from cxc_cobro_x_Anticipo_det
		where IdEmpresa =@i_idempresa
		and IdAnticipo =@i_idAnticipo
	)


select '============================= cobro x caja movimiento  ========================'	
select * 
from cxc_cobro_x_caj_Caja_Movimiento	A
where cast(A.cbr_IdEmpresa as varchar(20))+ cast(A.cbr_IdSucursal as varchar(20))+ cast(A.cbr_IdCobro as varchar(20))
in (
		select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
		from cxc_cobro_x_Anticipo_det
		where IdEmpresa =@i_idempresa
		and IdAnticipo =@i_idAnticipo
	)


select '============================= caja movimiento  ========================'	

select * 
from caj_Caja_Movimiento A
where cast(A.IdEmpresa as varchar(20)) + cast(A.IdTipocbte  as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + cast( A.mcj_IdTipocbte as varchar(20)) + cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where cast(A.cbr_IdEmpresa as varchar(20))+ cast(A.cbr_IdSucursal as varchar(20))+ cast(A.cbr_IdCobro as varchar(20))
		in (
				select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
				from cxc_cobro_x_Anticipo_det
				where IdEmpresa =@i_idempresa
				and IdAnticipo =@i_idAnticipo
			)
	)


select * 
from caj_Caja_Movimiento_det  A
where cast(A.IdEmpresa as varchar(20)) + cast(A.IdTipocbte  as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + cast( A.mcj_IdTipocbte as varchar(20)) + cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where cast(A.cbr_IdEmpresa as varchar(20))+ cast(A.cbr_IdSucursal as varchar(20))+ cast(A.cbr_IdCobro as varchar(20))
		in (
				select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
				from cxc_cobro_x_Anticipo_det
				where IdEmpresa =@i_idempresa
				and IdAnticipo =@i_idAnticipo
			)
	)


select '============================= comprobante contable  ========================'	

select * 
from ct_cbtecble   A
where cast(A.IdEmpresa as varchar(20)) + cast(A.IdTipocbte  as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + cast( A.mcj_IdTipocbte as varchar(20)) + cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where cast(A.cbr_IdEmpresa as varchar(20))+ cast(A.cbr_IdSucursal as varchar(20))+ cast(A.cbr_IdCobro as varchar(20))
		in (
				select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
				from cxc_cobro_x_Anticipo_det
				where IdEmpresa =@i_idempresa
				and IdAnticipo =@i_idAnticipo
			)
	)


select * 
from ct_cbtecble_det   A
where cast(A.IdEmpresa as varchar(20)) + cast(A.IdTipocbte  as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
		select 
		cast(A.mcj_IdEmpresa as varchar(20)) + cast( A.mcj_IdTipocbte as varchar(20)) + cast(A.mcj_IdCbteCble as varchar(20))
		from cxc_cobro_x_caj_Caja_Movimiento	A
		where cast(A.cbr_IdEmpresa as varchar(20))+ cast(A.cbr_IdSucursal as varchar(20))+ cast(A.cbr_IdCobro as varchar(20))
		in (
				select cast(IdEmpresa_Cobro as varchar(20)) + cast(IdSucursal_cobro as varchar(20)) + cast(IdCobro_cobro as varchar(20))
				from cxc_cobro_x_Anticipo_det
				where IdEmpresa =@i_idempresa
				and IdAnticipo =@i_idAnticipo
			)
	)
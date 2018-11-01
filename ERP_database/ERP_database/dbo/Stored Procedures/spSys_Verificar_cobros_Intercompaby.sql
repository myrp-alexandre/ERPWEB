-- exec spSys_Verificar_cobros_Intercompaby 1,2

CREATE proc [dbo].[spSys_Verificar_cobros_Intercompaby]
(
 @i_idempresa int
,@i_idcancelacion numeric
)
as

/*
declare @i_idempresa int
declare @i_idcancelacion numeric
*/

/*
select @i_idcancelacion =max(IdCancelacion)
from cxc_cancelacion_Intercompany
where IdEmpresa=@i_idempresa
*/

/*

delete from cxc_cancelacion_Intercompany_det
delete  from cxc_cancelacion_Intercompany


*/

select * from cxc_cancelacion_Intercompany
where IdEmpresa=@i_idempresa
and IdCancelacion =@i_idcancelacion


select * from cxc_cancelacion_Intercompany_det
where IdEmpresa=@i_idempresa
and IdCancelacion =@i_idcancelacion



select * 
from vwcxc_cancelacion_Intercompany
where IdEmpresa =@i_idempresa
and IdCancelacion =@i_idcancelacion


select * 
from cxc_cobro
where cast(IdEmpresa as varchar(20)) + cast(IdSucursal as varchar(20)) + cast(IdCobro  as varchar(20))
in
(
		select 
		cast(cbr_IdEmpresa as varchar(20)) + cast(cbr_IdSucursal as varchar(20)) 
		+ cast(cbr_IdCobro  as varchar(20))
		from cxc_cancelacion_Intercompany_det
		where IdEmpresa=@i_idempresa
		and IdCancelacion =@i_idcancelacion
)

select * 
from cxc_cobro_det
where cast(IdEmpresa as varchar(20)) + cast(IdSucursal as varchar(20)) + cast(IdCobro  as varchar(20))
in
(
		select 
		cast(cbr_IdEmpresa as varchar(20)) + cast(cbr_IdSucursal as varchar(20)) 
		+ cast(cbr_IdCobro  as varchar(20))
		from cxc_cancelacion_Intercompany_det
		where IdEmpresa=@i_idempresa
		and IdCancelacion =@i_idcancelacion
)


SELECT * FROM dbo.vwcxc_cancelacion_Intercompany_x_cxc_cobro_det
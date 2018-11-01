
CREATE  proc [dbo].[spSys_Cxc_Insert_estadoCobro_x_cobro]
as
insert into cxc_cobro_x_EstadoCobro
(
IdEmpresa			,IdSucursal		,IdCobro		,IdEstadoCobro		,IdCobro_tipo    
,IdCbte_vta_nota	,observacion	,Fecha			,nt_IdSucursal		,nt_IdBodega 
,nt_IdNota			,IdBanco
)
select IdEmpresa,IdSucursal,IdCobro,B.IdEstadoCobro_Inicial,B.IdCobro_tipo,null,'**sis**',GETDATE(),0,0,0,0
from cxc_cobro A,cxc_cobro_tipo B
where 
cast(IdEmpresa as varchar(20)) + cast( IdSucursal as varchar(20)) + cast(IdCobro as varchar(20)) 
not in 
(
	select 
	cast(IdEmpresa as varchar(20)) + cast( IdSucursal as varchar(20)) + cast(IdCobro as varchar(20))
	from cxc_cobro_x_EstadoCobro
	
)
and A.IdCobro_tipo=B.IdCobro_tipo
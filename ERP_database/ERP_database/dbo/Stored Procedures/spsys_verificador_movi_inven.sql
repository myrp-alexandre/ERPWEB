

--select * from in_movi_inve where IdNumMovi=16 and IdMovi_inven_tipo=1
--select * from in_movi_inve_detalle  where IdNumMovi=16 and IdMovi_inven_tipo=1

--  exec [spsys_verificador_movi_inven] 1,1,1,1,18

CREATE proc [dbo].[spsys_verificador_movi_inven]
(
 @i_idempresa int
,@i_idsucursal int
,@i_idbodega int
,@i_idTipo_Movi_Inven int
,@i_idMovi_Inven decimal
)
as
/*
declare @i_idnum float
declare @i_tipo_movi_inven float
set @i_idnum =7
set @i_tipo_movi_inven=1
*/


select * from in_movi_inve 
where IdEmpresa=@i_idempresa 
and IdSucursal=@i_idsucursal and IdBodega=@i_idbodega 
and IdMovi_inven_tipo=@i_idTipo_Movi_Inven 
and IdNumMovi=@i_idMovi_Inven

select * from in_movi_inve_detalle 
where IdEmpresa=@i_idempresa and IdSucursal=@i_idsucursal
 and IdBodega=@i_idbodega
  and IdMovi_inven_tipo=@i_idTipo_Movi_Inven
   and IdNumMovi=@i_idMovi_Inven

select * from vwIn_VistaParaContabilizarInventario
where IdEmpresa=@i_idempresa 
and IdSucursal=@i_idsucursal
 and IdBodega=@i_idbodega
  and IdNumMovi=@i_idMovi_Inven
and IdMovi_inven_tipo=@i_idTipo_Movi_Inven

select * from in_movi_inve_x_ct_cbteCble 
where IdEmpresa=@i_idempresa 
and IdMovi_inven_tipo=@i_idTipo_Movi_Inven
and IdSucursal=@i_idsucursal
 and IdBodega=@i_idbodega
  and IdNumMovi=@i_idMovi_Inven


select * from ct_cbtecble A
where 
cast(A.IdEmpresa as varchar(20)) +  cast(A.IdTipoCbte as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
	select cast(A.IdEmpresa as varchar(20))+ cast(A.IdTipoCbte as varchar(20))+ cast(A.IdCbteCble as varchar(20))
	from in_movi_inve_x_ct_cbteCble A
	where A.IdEmpresa=@i_idempresa 
	and A.IdMovi_inven_tipo=@i_idTipo_Movi_Inven
	and A.IdSucursal=@i_idsucursal
	 and A.IdBodega=@i_idbodega
	  and A.IdNumMovi=@i_idMovi_Inven
)

select * from ct_cbtecble_det A
where 
cast(A.IdEmpresa as varchar(20)) +  cast(A.IdTipoCbte as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
	select cast(A.IdEmpresa as varchar(20))+ cast(A.IdTipoCbte as varchar(20))+ cast(A.IdCbteCble as varchar(20))
	from in_movi_inve_x_ct_cbteCble A
	where A.IdEmpresa=@i_idempresa 
	and A.IdMovi_inven_tipo=@i_idTipo_Movi_Inven
	and A.IdSucursal=@i_idsucursal
	 and A.IdBodega=@i_idbodega
	  and A.IdNumMovi=@i_idMovi_Inven
)

select '**DIARIO DE REVERSO***'

select * 
from ct_cbtecble_Reversado a
where 
cast(A.IdEmpresa as varchar(20)) +  cast(A.IdTipoCbte as varchar(20)) + cast(A.IdCbteCble as varchar(20))
in (
	select cast(A.IdEmpresa as varchar(20))+ cast(A.IdTipoCbte as varchar(20))+ cast(A.IdCbteCble as varchar(20))
	from in_movi_inve_x_ct_cbteCble A
	where A.IdEmpresa=@i_idempresa 
	and A.IdMovi_inven_tipo=@i_idTipo_Movi_Inven
	and A.IdSucursal=@i_idsucursal
	 and A.IdBodega=@i_idbodega
	  and A.IdNumMovi=@i_idMovi_Inven
)
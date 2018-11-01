create proc spSys_Actualizar_fecha_OG_vs_RET
as

declare @idcbte_og numeric
declare @ifecha date
declare @confirmar_Update bit

set @idcbte_og =75
set @ifecha ='22/06/2016'
set @confirmar_Update =1

select A.co_FechaContabilizacion,A.*
from cp_orden_giro A where a.IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7
 
select A.cb_Fecha,A.* from ct_cbtecble A where A.IdCbteCble=@idcbte_og and A.IdTipoCbte=7

select A.fecha ,A.* from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7

select B.cb_Fecha, * from cp_retencion_x_ct_cbtecble A ,ct_cbtecble B 
where A.ct_IdEmpresa=B.IdEmpresa
and A.ct_IdTipoCbte=B.IdTipoCbte
and A.ct_IdCbteCble=B.IdCbteCble
and A.rt_IdRetencion=(select A.IdRetencion from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7 )




if (@confirmar_Update =1)
begin

update cp_orden_giro 
set co_FechaContabilizacion=@ifecha
from cp_orden_giro A where a.IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7
 
update ct_cbtecble 
set cb_Fecha =@ifecha
from ct_cbtecble A where A.IdCbteCble=@idcbte_og and A.IdTipoCbte=7

update cp_retencion 
set fecha =@ifecha
from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7


	update ct_cbtecble 
	set cb_Fecha=@ifecha
	from cp_retencion_x_ct_cbtecble A ,ct_cbtecble B 
	where A.ct_IdEmpresa=B.IdEmpresa
	and A.ct_IdTipoCbte=B.IdTipoCbte
	and A.ct_IdCbteCble=B.IdCbteCble
	and A.rt_IdRetencion=(select A.IdRetencion from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7 )

end

select '=========================================== despues de actualizar =========================='

select A.co_FechaContabilizacion,A.*
from cp_orden_giro A where a.IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7
 
select A.cb_Fecha,A.* from ct_cbtecble A where A.IdCbteCble=@idcbte_og and A.IdTipoCbte=7

select A.fecha ,A.* from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7

select B.cb_Fecha, * from cp_retencion_x_ct_cbtecble A ,ct_cbtecble B 
where A.ct_IdEmpresa=B.IdEmpresa
and A.ct_IdTipoCbte=B.IdTipoCbte
and A.ct_IdCbteCble=B.IdCbteCble
and A.rt_IdRetencion=(select A.IdRetencion from cp_retencion A where IdCbteCble_Ogiro=@idcbte_og and IdTipoCbte_Ogiro=7 )
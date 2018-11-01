
--  exec [spSys_Verificador_Orden_Giro_retencion] 1,7,556

CREATE proc [dbo].[spSys_Verificador_Orden_Giro_retencion] 
(
	 @i_idempresa int
	 ,@i_pa_TipoCbte_OG int
	,@i_idordenGiro numeric
)

as

/*
declare @i_idempresa int
declare @i_idordenGiro int


set @i_idempresa =1
set @i_idordenGiro =46
*/


select 'orden de giro...'
select * from cp_orden_giro where IdEmpresa =@i_idempresa and IdCbteCble_Ogiro=@i_idordenGiro and IdTipoCbte_Ogiro=@i_pa_TipoCbte_OG
select 'cab diario O/G...'
select * from ct_cbtecble where IdEmpresa =@i_idempresa and IdCbteCble=@i_idordenGiro and IdTipoCbte =@i_pa_TipoCbte_OG
select 'det diario O/G...'
select * from ct_cbtecble_det  where IdEmpresa =@i_idempresa and IdCbteCble=@i_idordenGiro and IdTipoCbte =@i_pa_TipoCbte_OG

select 'cab retencion...'
select * from cp_retencion 
where IdEmpresa =@i_idempresa and IdCbteCble_Ogiro=@i_idordenGiro and IdTipoCbte_Ogiro=@i_pa_TipoCbte_OG

declare @w_rt_IdEmpresa int
declare @w_rt_IdRetencion numeric

select @w_rt_IdEmpresa =IdEmpresa,@w_rt_IdRetencion=IdRetencion from cp_retencion 
where IdEmpresa =@i_idempresa and IdCbteCble_Ogiro=@i_idordenGiro and IdTipoCbte_Ogiro=@i_pa_TipoCbte_OG


select 'det retencion...'
select det.* from cp_retencion_det det ,cp_retencion cab
where 
det.IdEmpresa=cab.IdEmpresa
and det.IdRetencion=cab.IdRetencion
and cab.IdEmpresa =@i_idempresa and cab.IdCbteCble_Ogiro=@i_idordenGiro and cab.IdTipoCbte_Ogiro=@i_pa_TipoCbte_OG

select 'Tabla intermedia retencion cp_retencion_x_ct_cbtecble ...'
select ret_x_cbt.* from cp_retencion_x_ct_cbtecble ret_x_cbt,cp_retencion cab
where ret_x_cbt.rt_IdEmpresa=cab.IdEmpresa
and ret_x_cbt.rt_IdRetencion=cab.IdRetencion
and rt_IdEmpresa =@w_rt_IdEmpresa and rt_IdRetencion=@w_rt_IdRetencion

select 'cab diario de retencion...'
select A.*
from ct_cbtecble A,cp_retencion_x_ct_cbtecble B
where A.IdEmpresa=B.ct_IdEmpresa
and A.IdTipoCbte=B.ct_IdTipoCbte
and A.IdCbteCble=B.ct_IdCbteCble
and B.rt_IdEmpresa=@w_rt_IdEmpresa
and B.rt_IdRetencion=@w_rt_IdRetencion

select 'det diario de retencion...'
select A.*
from ct_cbtecble_det A,cp_retencion_x_ct_cbtecble B
where A.IdEmpresa=B.ct_IdEmpresa
and A.IdTipoCbte=B.ct_IdTipoCbte
and A.IdCbteCble=B.ct_IdCbteCble
and B.rt_IdEmpresa=@w_rt_IdEmpresa
and B.rt_IdRetencion=@w_rt_IdRetencion


select * from cp_reembolso a where a.IdEmpresa = @i_idempresa 
and a.IdCbteCble_Ogiro = @i_idordenGiro and a.IdTipoCbte_Ogiro = @i_pa_TipoCbte_OG
--  exec spSys_Iniciar_Orden_Giro 1

CREATE PROC [dbo].[spSys_Iniciar_Orden_Giro]
(
@i_idempresa int
)
as


declare @i_pa_tipocbte_og int
declare @i_pa_IdTipoCbte_x_Retencion int


select @i_pa_tipocbte_og=pa_TipoCbte_OG
,@i_pa_IdTipoCbte_x_Retencion=pa_IdTipoCbte_x_Retencion
from cp_parametros
where IdEmpresa =@i_idempresa



DELETE cp_orden_pago_det
where 
cast(IdEmpresa as varchar(20))+ cast(IdOrdenPago  as varchar(20))
in(

	select cast(IdEmpresa as varchar(20))+ cast(IdOrdenPago  as varchar(20))
	from cp_orden_pago  
	where IdTipo_op='FACT_PROVEE'
	and IdEmpresa =@i_idempresa
)

DELETE cp_orden_pago  
where IdTipo_op='FACT_PROVEE'
and IdEmpresa =@i_idempresa

DELETE cp_orden_giro_pagos
DELETE cp_orden_giro_pagos_sri
DELETE cp_orden_giro_x_imp_ordencompra_ext
DELETE cp_reembolso
DELETE cp_retencion_x_ct_cbtecble
DELETE cp_retencion_det 
DELETE cp_retencion
DELETE cp_orden_giro 

delete ct_cbtecble_det where IdEmpresa =@i_idempresa  and IdTipoCbte =@i_pa_tipocbte_og
delete ct_cbtecble where IdEmpresa =@i_idempresa  and IdTipoCbte =@i_pa_tipocbte_og


delete ct_cbtecble_det where IdEmpresa =@i_idempresa  and IdTipoCbte =@i_pa_IdTipoCbte_x_Retencion
delete ct_cbtecble where IdEmpresa =@i_idempresa  and IdTipoCbte =@i_pa_IdTipoCbte_x_Retencion
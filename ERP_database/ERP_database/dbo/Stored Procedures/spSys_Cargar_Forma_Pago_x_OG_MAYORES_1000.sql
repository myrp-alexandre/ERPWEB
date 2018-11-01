create proc spSys_Cargar_Forma_Pago_x_OG_MAYORES_1000
AS
insert into cp_orden_giro_pagos_sri 
(IdEmpresa		,IdCbteCble_Ogiro		,IdTipoCbte_Ogiro	,codigo_pago_sri	,formas_pago_sri )
select 
OG.IdEmpresa	,Og.IdCbteCble_Ogiro	,OG.IdTipoCbte_Ogiro,'01'				,'SIN UTILIZACION DEL SISTEMA FINANCIERO'
from cp_orden_giro OG
where OG.co_total>=1000
and 
not exists(
		select * from cp_orden_giro_pagos_sri A
		where A.IdEmpresa=OG.IdEmpresa
		and A.IdCbteCble_Ogiro=OG.IdCbteCble_Ogiro
		and A.IdTipoCbte_Ogiro=OG.IdTipoCbte_Ogiro
)
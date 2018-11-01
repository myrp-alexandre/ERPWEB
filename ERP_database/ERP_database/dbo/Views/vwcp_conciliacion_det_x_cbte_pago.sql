create view [dbo].[vwcp_conciliacion_det_x_cbte_pago]
as
select IdEmpresa, IdConciliacion,IdEmpresa_pago,IdCbteCble_pago,IdTipoCbte_pago
from cp_conciliacion_det 
group by IdEmpresa, IdConciliacion,IdEmpresa_pago,IdCbteCble_pago,IdTipoCbte_pago
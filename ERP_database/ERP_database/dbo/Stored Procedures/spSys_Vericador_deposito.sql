CREATE proc [dbo].[spSys_Vericador_deposito]
(
@I_IdEmpresa int
,@I_NumDeposito numeric 
)
as
/*
DECLARE @I_IdEmpresa int
DECLARE @I_NumDeposito numeric 
*/




DECLARE @I_IdTipocbte int
DECLARE @I_IdCbteCble numeric
set @I_IdCbteCble =@I_NumDeposito


select @I_IdTipocbte=IdTipoCbteCble
from ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo
where CodTipoCbteBan='DEPO'
and  idempresa=@I_IdEmpresa



select 'Tipo Comprobante Ban/Conta'
select *
from ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo
where CodTipoCbteBan='DEPO'
and  idempresa=@I_IdEmpresa

select 'cabecera Bancos'
/*
SELECT      IdEmpresa, IdCbteCble, IdTipocbte, Cod_Cbtecble, IdPeriodo, IdBanco, IdProveedor, cb_Fecha, cb_Observacion, cb_secuencia, cb_Valor, cb_Cheque, 
                      cb_ChequeImpreso, cb_FechaCheque, IdUsuario, IdUsuario_Anu, FechaAnulacion, Fecha_Transac, Fecha_UltMod, IdUsuarioUltMod, Estado, MotivoAnulacion, ip, 
                      nom_pc, cb_giradoA, cb_ciudadChq, IdCbteCble_Anulacion, IdTipoCbte_Anulacion, IdTipoFlujo, IdTipoNota, IdTransaccion, Por_Anticipo, PosFechado
FROM         ba_Cbte_Ban
WHERE     (IdEmpresa = @I_IdEmpresa) 
AND (IdCbteCble = @I_IdCbteCble) 
AND (IdTipocbte = @I_IdTipocbte)
*/

select 'cabecera contable'
SELECT     IdEmpresa, IdTipoCbte, IdCbteCble, CodCbteCble, IdPeriodo, cb_Fecha, cb_Valor, cb_Observacion, 0 cb_Secuencia, cb_Estado, cb_Anio, cb_mes, IdUsuario, 
                      IdUsuarioAnu, cb_MotivoAnu, IdUsuarioUltModi, cb_FechaAnu, cb_FechaTransac, cb_FechaUltModi, 'N' cb_Mayorizado
FROM         ct_cbtecble
WHERE     (IdEmpresa = @I_IdEmpresa) 
AND (IdCbteCble = @I_IdCbteCble) 
AND (IdTipocbte = @I_IdTipocbte)


select 'detalle contable'
SELECT      IdEmpresa, IdTipoCbte, IdCbteCble, secuencia, IdCtaCble, IdCentroCosto, IdCentroCosto_sub_centro_costo, dc_Valor, dc_Observacion, 0 dc_Numconciliacion, 
                      'N' dc_EstaConciliado
FROM         ct_cbtecble_det
WHERE     (IdEmpresa = @I_IdEmpresa) 
AND (IdCbteCble = @I_IdCbteCble) 
AND (IdTipocbte = @I_IdTipocbte)



select 'tabla intermedia banco caja'
SELECT     mcj_IdEmpresa, mcj_IdCbteCble, mcj_IdTipocbte, mba_IdEmpresa, mba_IdCbteCble, mba_IdTipocbte
FROM         ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito
WHERE     (mba_IdEmpresa = @I_IdEmpresa) AND (mba_IdCbteCble =@I_IdCbteCble) AND (mba_IdTipocbte = @I_IdTipocbte)
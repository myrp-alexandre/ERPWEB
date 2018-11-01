-- exec spSys_EliminarCheque_y_LiberarOP 1,2,2,1
CREATE procedure spSys_EliminarCheque_y_LiberarOP
(
 @i_IdEmpresa int
,@i_IdTipoCbte int
,@i_IdCbteCble numeric
,@i_Eliminar bit
)
as
begin

select 'ba_Talonario_cheques_x_banco ** talonario usado'
select * from ba_Talonario_cheques_x_banco where IdEmpresa_cbtecble_Usado=@i_IdEmpresa and IdTipoCbte_cbtecble_Usado=@i_IdTipoCbte and IdCbteCble_cbtecble_Usado=@i_IdCbteCble
select 'ba_Cbte_Ban ** movi bancos'
select * from ba_Cbte_Ban where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte
select 'ct_cbtecble_det ** detalle contable'
select * from ct_cbtecble_det where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte
select 'ct_cbtecble ** cabecera contable'
select * from ct_cbtecble where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte
select 'cp_orden_pago_cancelaciones ** cancelaciones por op'
select * from cp_orden_pago_cancelaciones  where IdEmpresa_pago=@i_IdEmpresa and IdTipoCbte_pago=@i_IdTipoCbte and IdCbteCble_pago=@i_IdCbteCble


if (@i_Eliminar=1)
Begin
		print 'ba_Talonario_cheques_x_banco ** update '
			update ba_Talonario_cheques_x_banco 
			set Usado=0 ,Fecha_uso=null
			,IdEmpresa_cbtecble_Usado=null
			,IdTipoCbte_cbtecble_Usado=null
			,IdCbteCble_cbtecble_Usado=null
			where IdEmpresa_cbtecble_Usado=@i_IdEmpresa and IdTipoCbte_cbtecble_Usado=@i_IdTipoCbte and IdCbteCble_cbtecble_Usado=@i_IdCbteCble

	    print 'cp_orden_pago_cancelaciones ** delete cancelaciones por op'
		delete from cp_orden_pago_cancelaciones  where IdEmpresa_pago=@i_IdEmpresa and IdTipoCbte_pago=@i_IdTipoCbte and IdCbteCble_pago=@i_IdCbteCble

		print 'ba_Cbte_Ban ** delete movi bancos'
			delete from ba_Cbte_Ban where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte

		print 'ct_cbtecble_det ** detalle contable'
		delete from ct_cbtecble_det where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte
		print 'ct_cbtecble ** cabecera contable'
		delete from ct_cbtecble where IdEmpresa=@i_IdEmpresa and IdCbteCble=@i_IdCbteCble and IdTipocbte=@i_IdTipoCbte
		
end 


end
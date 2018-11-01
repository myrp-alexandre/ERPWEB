--EXEC [spSys_Ban_Arreglando_observacion_cbteBancarios]  3,'01/01/2017','30/04/2017'

CREATE proc [dbo].[spSys_Ban_Arreglando_observacion_cbteBancarios]  
@i_IdEmpresa int,
@i_fechaIni datetime,
@i_fechaFin datetime
as
BEGIN
--set @i_fechaIni ='01/01/2017'
--set @i_fechaFin ='31/01/2017'

declare @C_IdEmpresa int
 declare @C_IdCbteCble numeric
 declare  @C_IdTipocbte int
 declare  @C_cb_Observacion varchar(1000)
 declare  @C_num_cheque varchar(20)

 declare  @C_Documentos_para_observacion varchar(max)

 declare @W_Tiene_Pago bit
 set @W_Tiene_Pago=0

 declare @W_Observacion_new varchar(max)
 declare @W_Observacion_cbte varchar(max)

 declare @w_IdEmpresa_pago int
 declare @w_IdTipoCbte_pago int
 declare @w_IdCbteCble_pago numeric
 declare @w_Codigo varchar(20)
 declare @w_Num_doc varchar(20)
 declare @w_IdOrdenPago_op numeric
 declare @w_IdCbteCble_cxp numeric
 declare @w_Nombre_prov varchar(max)





declare Cursor_Cancelacion_x_OP  cursor for

SELECT       IdEmpresa, IdCbteCble, IdTipocbte, cb_Observacion,cb_Cheque
FROM            ba_Cbte_Ban A
where IdEmpresa=@i_IdEmpresa
and A.cb_Fecha between @i_fechaIni and @i_fechaFin
and A.IdTipocbte=2
--and A.cb_Cheque like '%73551'
OPEN Cursor_Cancelacion_x_OP  
  
FETCH NEXT FROM Cursor_Cancelacion_x_OP   
INTO @C_IdEmpresa, @C_IdCbteCble, @C_IdTipocbte,@C_cb_Observacion,@C_num_cheque
 
 
  
WHILE @@FETCH_STATUS = 0  
BEGIN  


    select  @C_IdEmpresa, @C_IdCbteCble, @C_IdTipocbte,@C_cb_Observacion
	set @W_Observacion_new ='Canc./ '	
	set @C_Documentos_para_observacion=''

/*
	
*/




				declare Cursor_Forma_Pago_x_Cbte_Bancario cursor for
							select Querry_x_doc.IdEmpresa_pago,Querry_x_doc.IdTipoCbte_pago,Querry_x_doc.IdCbteCble_pago
							,Querry_x_doc.Codigo,Querry_x_doc.Num_doc,Querry_x_doc.IdOrdenPago_op,Querry_x_doc.IdCbteCble_cxp
							,Querry_x_doc.nombre
							from (
		
										SELECT        can.IdEmpresa_pago, can.IdTipoCbte_pago, can.IdCbteCble_pago
										,substring(tipd.Codigo,1,2) Codigo				,cast( og.co_factura as numeric) as Num_doc						,can.IdOrdenPago_op					,can.IdCbteCble_cxp
										,ltrim(rtrim(per.pe_nombreCompleto)) as nombre
										FROM            cp_orden_pago_cancelaciones AS can INNER JOIN
																 cp_orden_giro AS og ON can.IdEmpresa_cxp = og.IdEmpresa AND can.IdTipoCbte_cxp = og.IdTipoCbte_Ogiro AND 
																 can.IdCbteCble_cxp = og.IdCbteCble_Ogiro INNER JOIN
																 cp_TipoDocumento AS tipd ON og.IdOrden_giro_Tipo = tipd.CodTipoDocumento
																 inner join cp_proveedor as prov on prov.IdEmpresa = og.IdEmpresa and prov.IdProveedor = og.IdProveedor 
																 inner join tb_persona as per on prov.IdPersona = per.IdPersona
										WHERE        can.IdEmpresa_pago = @C_IdEmpresa AND can.IdTipoCbte_pago =@C_IdTipocbte and can.IdCbteCble_pago=@C_IdCbteCble

	
										union

										SELECT        can.IdEmpresa_pago, can.IdTipoCbte_pago, can.IdCbteCble_pago
										,'ND'       ,iif(cp_nota_DebCre.cn_Nota is null or cp_nota_DebCre.cn_Nota = '',iif(cp_nota_DebCre.cod_nota is null or cp_nota_DebCre.cod_nota = '', cast(cp_nota_DebCre.IdCbteCble_Nota as varchar(20)),cast(cp_nota_DebCre.cod_nota as numeric)),cast(cp_nota_DebCre.cn_Nota as numeric))            , can.IdOrdenPago_op				  , cp_nota_DebCre.IdCbteCble_Nota
										,ltrim(rtrim(per.pe_nombreCompleto))
										FROM            cp_orden_pago_cancelaciones AS can INNER JOIN
											cp_nota_DebCre ON can.IdEmpresa_cxp = cp_nota_DebCre.IdEmpresa AND can.IdTipoCbte_cxp = cp_nota_DebCre.IdTipoCbte_Nota AND 
											can.IdCbteCble_cxp = cp_nota_DebCre.IdCbteCble_Nota inner join cp_proveedor as prov on prov.IdEmpresa = cp_nota_DebCre.IdEmpresa and prov.IdProveedor = cp_nota_DebCre.IdProveedor 
											inner join tb_persona as per on prov.IdPersona = per.IdPersona
										WHERE        (can.IdEmpresa_pago = @C_IdEmpresa) AND (can.IdTipoCbte_pago = @C_IdTipocbte) AND (can.IdCbteCble_pago = @C_IdCbteCble)
				
										union
										SELECT        can.IdEmpresa_pago, can.IdTipoCbte_pago, can.IdCbteCble_pago
										,'OP'				,cast(can.IdOrdenPago_op as varchar(20))				,can.IdOrdenPago_op					,can.IdCbteCble_cxp
										,ltrim(rtrim(per.pe_nombreCompleto)) as nombre
										FROM            cp_orden_pago_cancelaciones AS can INNER JOIN
												cp_orden_pago AS OP ON can.IdEmpresa_op = OP.IdEmpresa AND can.IdOrdenPago_op = OP.IdOrdenPago
												inner join vwtb_persona_beneficiario prov on prov.IdEmpresa = op.IdEmpresa and prov.IdTipo_Persona = op.IdTipo_Persona
												and prov.IdEntidad = op.IdEntidad and prov.IdPersona = op.IdPersona
												inner join tb_persona as per on prov.IdPersona = per.IdPersona
										WHERE        (IdEmpresa_pago = @C_IdEmpresa) AND (IdTipoCbte_pago = @C_IdTipocbte) AND (IdCbteCble_pago = @C_IdCbteCble)
										and not exists
										(
												select * from 
												(
														select og.IdEmpresa,og.IdTipoCbte_Ogiro,og.IdCbteCble_Ogiro 
														from cp_orden_giro og
														union
														select nd.IdEmpresa,nd.IdTipoCbte_Nota,nd.IdCbteCble_Nota
														 from cp_nota_DebCre nd where DebCre='D'
												 ) facP_ND
												 where facP_ND.IdEmpresa=can.IdEmpresa_cxp
												 and facP_ND.IdTipoCbte_Ogiro=can.IdTipoCbte_cxp
												 and facP_ND.IdCbteCble_Ogiro=can.IdCbteCble_cxp
										)
				
							) as Querry_x_doc
	


				OPEN Cursor_Forma_Pago_x_Cbte_Bancario  
  
				FETCH NEXT FROM Cursor_Forma_Pago_x_Cbte_Bancario   
				INTO @w_IdEmpresa_pago ,@w_IdTipoCbte_pago ,@w_IdCbteCble_pago ,@w_Codigo ,@w_Num_doc ,@w_IdOrdenPago_op 
					 ,@w_IdCbteCble_cxp , @w_Nombre_prov
 
 
  
				WHILE @@FETCH_STATUS = 0  
				BEGIN  


					
					set @C_Documentos_para_observacion= @C_Documentos_para_observacion + @w_Codigo + '#:'  +@w_Num_doc + ' '
					
					select @w_Codigo, @w_Num_doc, @C_Documentos_para_observacion					
					
					FETCH NEXT FROM Cursor_Forma_Pago_x_Cbte_Bancario   
					INTO @w_IdEmpresa_pago ,@w_IdTipoCbte_pago ,@w_IdCbteCble_pago ,@w_Codigo ,@w_Num_doc ,@w_IdOrdenPago_op 
					 ,@w_IdCbteCble_cxp ,@w_Nombre_prov

				END  

				CLOSE Cursor_Forma_Pago_x_Cbte_Bancario  
				DEALLOCATE Cursor_Forma_Pago_x_Cbte_Bancario
    


	set @W_Observacion_new= @W_Observacion_new +  @C_Documentos_para_observacion
	select @W_Observacion_new
	set @W_Observacion_cbte = 'Cheque #:' +  @C_num_cheque + ' Girado a: '+ltrim(rtrim(@w_Nombre_prov)) +' Canc./ '	+  @C_Documentos_para_observacion
	select @W_Observacion_cbte

	---- UPDATE AL COMPROBANTE 
	if(@w_Nombre_prov is not null)
	begin
	UPDATE	ba_Cbte_Ban	
	set cb_Observacion= case when ba_Cbte_Ban.Estado = 'I' THEN '**ANULADO** '+ @W_Observacion_new ELSE @W_Observacion_new END
	where IdEmpresa=@C_IdEmpresa
	and IdTipocbte=@C_IdTipocbte
	and IdCbteCble=@C_IdCbteCble

	UPDATE	ct_cbtecble
	set cb_Observacion= case when ct_cbtecble.cb_Estado = 'I' THEN '**ANULADO** '+ @W_Observacion_cbte ELSE @W_Observacion_cbte END
	where IdEmpresa=@C_IdEmpresa
	and IdTipocbte=@C_IdTipocbte
	and IdCbteCble=@C_IdCbteCble

	UPDATE	ct_cbtecble_det
	set dc_Observacion = ''
	where IdEmpresa=@C_IdEmpresa
	and IdTipocbte=@C_IdTipocbte
	and IdCbteCble=@C_IdCbteCble
	end
	FETCH NEXT FROM Cursor_Cancelacion_x_OP   
	INTO @C_IdEmpresa, @C_IdCbteCble, @C_IdTipocbte,@C_cb_Observacion,@C_num_cheque
END  



CLOSE Cursor_Cancelacion_x_OP  
DEALLOCATE Cursor_Cancelacion_x_OP

END
--select * from cp_nota_DebCre where IdCbteCble_Nota=1158
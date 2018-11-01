
-- exec sp_sis_Verificar_flujo_ajuste_fisico 1,10

CREATE proc [dbo].[spSys_Verificar_flujo_ajuste_fisico]
(
 @i_IdEmpresa int
,@i_IdAjuste numeric
)

as
/*
declare @i_IdEmpresa int
declare @i_IdAjuste numeric
*/
declare @w_IdEmpresa    int
declare @w_IdSucursal   int
declare @w_IdBodega     int
declare @w_IdMovi_inven_tipo  int
declare @w_IdNumMovi numeric 

set @i_IdEmpresa =1
set @i_IdAjuste =5


select * from in_ajusteFisico
where IdEmpresa=@i_IdEmpresa and IdAjusteFisico=@i_IdAjuste

select * from in_AjusteFisico_Detalle 
where IdEmpresa=@i_IdEmpresa and IdAjusteFisico=@i_IdAjuste

select '**ingreso x inven'

select 
 @w_IdEmpresa=IdEmpresa   
,@w_IdSucursal=IdSucursal  
,@w_IdBodega=IdBodega    
,@w_IdMovi_inven_tipo=IdMovi_inven_tipo_Ing 
,@w_IdNumMovi=IdNumMovi_Ing                           
from in_ajusteFisico
where IdEmpresa=@i_IdEmpresa 
and IdAjusteFisico=@i_IdAjuste


select * from in_movi_inve
where 
	IdEmpresa   =@w_IdEmpresa
and IdSucursal  =@w_IdSucursal
and IdBodega    =@w_IdBodega
and IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and IdNumMovi=@w_IdNumMovi

select * from in_movi_inve_detalle
where 
	IdEmpresa   =@w_IdEmpresa
and IdSucursal  =@w_IdSucursal
and IdBodega    =@w_IdBodega
and IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and IdNumMovi=@w_IdNumMovi

select '**Egreso x inven'

select 
 @w_IdEmpresa=IdEmpresa   
,@w_IdSucursal=IdSucursal  
,@w_IdBodega=IdBodega    
,@w_IdMovi_inven_tipo=IdMovi_inven_tipo_Egr
,@w_IdNumMovi=IdNumMovi_Egr                         
from in_ajusteFisico
where IdEmpresa=@i_IdEmpresa 
and IdAjusteFisico=@i_IdAjuste


select * from in_movi_inve
where 
	IdEmpresa   =@w_IdEmpresa
and IdSucursal  =@w_IdSucursal
and IdBodega    =@w_IdBodega
and IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and IdNumMovi=@w_IdNumMovi

select * from in_movi_inve_detalle
where 
	IdEmpresa   =@w_IdEmpresa
and IdSucursal  =@w_IdSucursal
and IdBodega    =@w_IdBodega
and IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and IdNumMovi=@w_IdNumMovi


select ''

SELECT     in_movi_inve_x_ct_cbteCble.*
FROM         in_movi_inve INNER JOIN
in_movi_inve_x_ct_cbteCble 
ON in_movi_inve.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa 
AND in_movi_inve.IdSucursal = in_movi_inve_x_ct_cbteCble.IdSucursal 
AND in_movi_inve.IdBodega = in_movi_inve_x_ct_cbteCble.IdBodega AND 
in_movi_inve.IdMovi_inven_tipo = in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo 
AND in_movi_inve.IdNumMovi = in_movi_inve_x_ct_cbteCble.IdNumMovi
and in_movi_inve.IdEmpresa   =@w_IdEmpresa
and in_movi_inve.IdSucursal  =@w_IdSucursal
and in_movi_inve.IdBodega    =@w_IdBodega
and in_movi_inve.IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and in_movi_inve.IdNumMovi=@w_IdNumMovi



SELECT     ct_cbtecble.*
FROM         in_movi_inve INNER JOIN
                      in_movi_inve_x_ct_cbteCble ON in_movi_inve.IdEmpresa = in_movi_inve_x_ct_cbteCble.IdEmpresa AND 
                      in_movi_inve.IdSucursal = in_movi_inve_x_ct_cbteCble.IdSucursal AND in_movi_inve.IdBodega = in_movi_inve_x_ct_cbteCble.IdBodega AND 
                      in_movi_inve.IdMovi_inven_tipo = in_movi_inve_x_ct_cbteCble.IdMovi_inven_tipo AND 
                      in_movi_inve.IdNumMovi = in_movi_inve_x_ct_cbteCble.IdNumMovi INNER JOIN
                      ct_cbtecble ON in_movi_inve_x_ct_cbteCble.IdEmpresa = ct_cbtecble.IdEmpresa AND in_movi_inve_x_ct_cbteCble.IdTipoCbte = ct_cbtecble.IdTipoCbte AND 
                      in_movi_inve_x_ct_cbteCble.IdCbteCble = ct_cbtecble.IdCbteCble
and in_movi_inve.IdEmpresa   =@w_IdEmpresa
and in_movi_inve.IdSucursal  =@w_IdSucursal
and in_movi_inve.IdBodega    =@w_IdBodega
and in_movi_inve.IdMovi_inven_tipo =@w_IdMovi_inven_tipo
and in_movi_inve.IdNumMovi=@w_IdNumMovi
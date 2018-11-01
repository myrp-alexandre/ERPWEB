CREATE PROCEDURE [dbo].[spPRO_CUS_CID_Rpt003]  
(
@i_IdEmpresa Int, 
@i_IdListadoMateriales NUmERIC(18),
@i_IdUsuario varchar(20), 
@i_nom_pc varchar(50)
 ) 
 AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/
  BEGIN 
  delete from tbPRO_CUS_CID_Rpt003 where Idusuario = @i_IdUsuario and nom_pc = @i_nom_pc 
  Insert into tbPRO_CUS_CID_Rpt003 (
  IdEmpresa,  IdUsuario,  Fecha_Transac,  nom_pc,  IdListadoMateriales,  CodObra ,
   FechaReg ,Usuario ,Su_Descripcion ,
   --ot_descripcion ,
ob_descripcion ,lm_Observacion ,pr_codigo,pr_descripcion,Unidades,IdEstadoAprob)
  select 
cab.IdEmpresa, @i_IdUsuario, GETDATE(),@i_nom_pc ,  cab.IdListadoMateriales, cab.CodObra,
cab.FechaReg,cab.Usuario, cab.Su_Descripcion, 
--cab.ot_descripcion ,
cab.ob_descripcion, cab.lm_Observacion,
det.pr_codigo, det.pr_descripcion,det.Unidades ,
det.IdEstadoAprob
from vwcom_ListadoMateriales cab inner join vwcom_ListadoMateriales_Detalle  det
on cab.IdEmpresa = det.IdEmpresa and cab.IdListadoMateriales = det.IdListadoMateriales 
where cab.IdEmpresa = @i_IdEmpresa
and cab.IdListadoMateriales = @i_IdListadoMateriales 

 END
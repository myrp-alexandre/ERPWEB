CREATE PROCEDURE [dbo].[spPRO_CUS_CID_Rpt009] 
 (@i_IdEmpresa Int, @i_IdSucursal Int , @i_IdGrupoTrabajo numeric(18,0), @i_IdUsuario varchar(20), @i_nom_pc varchar(50) )  
 AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/
 BEGIN 
 Delete from tbPRO_CUS_CID_Rpt009 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc
 Insert Into tbPRO_CUS_CID_Rpt009 (IdEmpresa,IdUsuario,Fecha_Transac,
 nom_pc, IdSucursal,IdGrupoTrabajo, CodObra,IdLider,IdOrdenTaller,
Su_Descripcion,ob_descripcion, ot_descripcion,gt_Descripcion, et_descripcion,
mp_descripcion,lider,pe_nombreCompleto,Observacion)
Select cab.IdEmpresa, @i_IdUsuario,GETDATE(),@i_nom_pc,cab.IdSucursal, cab.IdGrupoTrabajo,  
'' CodObra,cab.IdLider,0 IdOrdenTaller,
cab.Su_Descripcion,'' ob_descripcion, '' as ot_descripcion,cab.gt_Descripcion,
cab.NombreEtapa as et_descripcion,
cab.DescripModelo as mp_descripcion, cab.pe_nombreCompleto as lider, det.pe_nombreCompleto, det.Observacion 
from vwprd_GrupoTrabajoCab  cab inner join vwprd_GrupoTrabajo_Det  det
on  cab.IdEmpresa = det.IdEmpresa and cab.IdGrupoTrabajo = det.IdGrupotrabajo 
Where cab.IdEmpresa = @i_IdEmpresa and cab.IdSucursal = @i_IdSucursal and 
 cab.IdGrupoTrabajo = @i_IdGrupoTrabajo
Select * from tbPRO_CUS_CID_Rpt009 

 --exec spPRO_CUS_CID_Rpt009 6,1,1,'',''
 END
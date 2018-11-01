
CREATE PROCEDURE [dbo].[spPRO_CUS_CID_Rpt010]  
(@i_IdEmpresa Int, 
@i_IdUsuario varchar(20), 
@i_nom_pc varchar(50),
@i_IdModeloProductivo int ) 
AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/ 
BEGIN 
Delete tbPRO_CUS_CID_Rpt010 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc 
Insert Into tbPRO_CUS_CID_Rpt010 (IdEmpresa, IdUsuario,Fecha_Transac, nom_pc, 
IdProcesoProductivo, ProcProd , CodObra,obra,IdEtapa ,NombreEtapa ,PorcentajeEtapa)
select pp.IdEmpresa,@i_IdUsuario,GETDATE(),@i_nom_pc,pp.IdProcesoProductivo, pp.Nombre , ob.CodObra,ob.Descripcion as obra,
et.IdEtapa , et.NombreEtapa ,et.PorcentajeEtapa
from prd_ProcesoProductivo pp
inner join prd_ProcesoProductivo_x_prd_obra TI
on pp.IdEmpresa = TI.IdEmpresa_Pr and pp.IdProcesoProductivo = TI.IdProcesoProductivo 
inner join prd_Obra ob
on ob.CodObra = TI.CodObra and ob.IdEmpresa = TI.IdEmpresa_obra 
inner join prd_EtapaProduccion et
on et.IdEmpresa = pp.IdEmpresa and et.IdProcesoProductivo = pp.IdProcesoProductivo 
Where pp.IdEmpresa =@i_IdEmpresa and  @i_IdModeloProductivo = pp.IdProcesoProductivo 
order by pp.IdEmpresa,pp.IdProcesoProductivo,ob.Descripcion,et.Posicion 

select * from tbPRO_CUS_CID_Rpt010 
--exec [spPRO_CUS_CID_Rpt010] 6,'','',1
END
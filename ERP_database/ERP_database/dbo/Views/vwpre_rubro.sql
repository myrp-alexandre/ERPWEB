CREATE VIEW vwpre_rubro AS

SELECT        dbo.pre_rubro.IdEmpresa, dbo.pre_rubro.IdRubro, dbo.pre_rubro.Descripcion, dbo.pre_rubro.IdCtaCble, dbo.ct_plancta.pc_Cuenta, dbo.pre_rubro.Estado, dbo.pre_rubro.IdUsuarioCreacion, dbo.pre_rubro.FechaCreacion, 
                         dbo.pre_rubro.IdUsuarioModificacion, dbo.pre_rubro.FechaModificacion, dbo.pre_rubro.IdUsuarioAnulacion, dbo.pre_rubro.FechaAnulacion, dbo.pre_rubro.MotivoAnulacion
FROM            dbo.ct_plancta INNER JOIN
                         dbo.pre_rubro ON dbo.ct_plancta.IdEmpresa = dbo.pre_rubro.IdEmpresa AND dbo.ct_plancta.IdCtaCble = dbo.pre_rubro.IdCtaCble
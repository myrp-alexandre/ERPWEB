CREATE view [dbo].[vwpre_Grupo_x_CtaCble] as
SELECT        dbo.pre_PresupuestoDet.IdEmpresa, dbo.pre_Presupuesto.IdSucursal, dbo.pre_PresupuestoDet.IdCtaCble, dbo.pre_PresupuestoPeriodo.FechaInicio, 
                         dbo.pre_PresupuestoPeriodo.FechaFin, dbo.pre_Presupuesto.IdGrupo, dbo.pre_Grupo.Descripcion
FROM            dbo.pre_Grupo INNER JOIN
                         dbo.pre_Presupuesto ON dbo.pre_Grupo.IdEmpresa = dbo.pre_Presupuesto.IdEmpresa AND dbo.pre_Grupo.IdGrupo = dbo.pre_Presupuesto.IdGrupo INNER JOIN
                         dbo.pre_PresupuestoDet ON dbo.pre_Presupuesto.IdEmpresa = dbo.pre_PresupuestoDet.IdEmpresa AND dbo.pre_Presupuesto.IdPresupuesto = dbo.pre_PresupuestoDet.IdPresupuesto INNER JOIN
                         dbo.pre_PresupuestoPeriodo ON dbo.pre_Presupuesto.IdEmpresa = dbo.pre_PresupuestoPeriodo.IdEmpresa AND dbo.pre_Presupuesto.IdPeriodo = dbo.pre_PresupuestoPeriodo.IdPeriodo
group by dbo.pre_PresupuestoDet.IdEmpresa, dbo.pre_Presupuesto.IdSucursal, dbo.pre_PresupuestoDet.IdCtaCble, dbo.pre_PresupuestoPeriodo.FechaInicio, 
 dbo.pre_PresupuestoPeriodo.FechaFin, dbo.pre_Presupuesto.IdGrupo, dbo.pre_Grupo.Descripcion
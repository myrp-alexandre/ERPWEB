create view vwpre_PresupuestoDet as
SELECT        dbo.pre_Presupuesto.IdEmpresa, dbo.pre_Presupuesto.IdPresupuesto, dbo.pre_Presupuesto.IdSucursal, dbo.pre_Presupuesto.IdPeriodo, dbo.pre_PresupuestoPeriodo.EstadoCierre, dbo.pre_Presupuesto.IdGrupo, 
                         dbo.pre_Presupuesto.Observacion, dbo.pre_Presupuesto.Estado, dbo.pre_Presupuesto.MontoSolicitado, dbo.pre_Presupuesto.MontoAprobado, dbo.pre_PresupuestoDet.Secuencia, dbo.pre_PresupuestoDet.IdRubro, 
                         dbo.pre_Rubro.Descripcion, dbo.pre_PresupuestoDet.IdCtaCble, dbo.pre_PresupuestoDet.Cantidad, dbo.pre_PresupuestoDet.Monto
FROM            dbo.pre_Presupuesto INNER JOIN
                         dbo.pre_PresupuestoDet ON dbo.pre_Presupuesto.IdEmpresa = dbo.pre_PresupuestoDet.IdEmpresa AND dbo.pre_Presupuesto.IdPresupuesto = dbo.pre_PresupuestoDet.IdPresupuesto INNER JOIN
                         dbo.pre_PresupuestoPeriodo ON dbo.pre_Presupuesto.IdEmpresa = dbo.pre_PresupuestoPeriodo.IdEmpresa AND dbo.pre_Presupuesto.IdPeriodo = dbo.pre_PresupuestoPeriodo.IdPeriodo LEFT OUTER JOIN
                         dbo.pre_Rubro ON dbo.pre_PresupuestoDet.IdEmpresa = dbo.pre_Rubro.IdEmpresa AND dbo.pre_PresupuestoDet.IdRubro = dbo.pre_Rubro.IdRubro
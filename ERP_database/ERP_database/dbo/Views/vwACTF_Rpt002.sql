CREATE VIEW dbo.vwACTF_Rpt002
AS
SELECT        act.IdEmpresa, act.IdActivoFijo, act.IdSucursal, act.IdActivoFijoTipo IdActijoFijoTipo, 1 IdTipoDepreciacion, act.Af_Codigo_Barra, 'lineal' nom_tipo_depreciacion, tip.Af_Descripcion, cat.Descripcion, suc.Su_Descripcion, act.Af_Nombre, 
                         0 IdDepartamento, mar.Descripcion AS Af_Marca, dis.Descripcion AS Af_Modelo, act.Af_NumSerie, col.Descripcion AS Af_Color, ubi.Descripcion AS Af_Ubicacion, act.Af_fecha_compra, act.Af_costo_compra, 
                         act.Af_Costo_historico, act.Af_Vida_Util, act.Af_Meses_depreciar, ISNULL(act.Af_ValorSalvamento, 0) AS Af_ValorSalvamento, ISNULL(act.Af_ValorResidual, 0) AS Af_ValorResidual, act.Estado_Proceso
FROM            dbo.Af_Activo_fijo AS act INNER JOIN
                         dbo.Af_Activo_fijo_tipo AS tip ON tip.IdEmpresa = act.IdEmpresa AND tip.IdActivoFijoTipo = act.IdActivoFijoTipo INNER JOIN
                         dbo.tb_sucursal AS suc ON suc.IdEmpresa = act.IdEmpresa AND suc.IdSucursal = act.IdSucursal INNER JOIN
                         dbo.Af_Catalogo AS cat ON cat.IdCatalogo = act.Estado_Proceso AND cat.IdTipoCatalogo = 'TIP_ESTADO_AF' INNER JOIN
                         
                         dbo.Af_Catalogo AS mar ON mar.IdCatalogo = act.IdCatalogo_Marca INNER JOIN
                         dbo.Af_Catalogo AS col ON col.IdCatalogo = act.IdCatalogo_Color INNER JOIN
                         dbo.Af_Catalogo AS dis ON dis.IdCatalogo = act.IdCatalogo_Modelo LEFT OUTER JOIN
                         dbo.Af_Catalogo AS ubi ON ubi.IdCatalogo = act.IdTipoCatalogo_Ubicacion
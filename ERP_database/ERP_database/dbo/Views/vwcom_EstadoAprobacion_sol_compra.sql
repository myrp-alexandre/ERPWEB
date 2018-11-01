
CREATE view [dbo].[vwcom_EstadoAprobacion_sol_compra]
as
SELECT     IdCatalogocompra_tipo AS IdTipoCatalogo, CodCatalogo AS Codigo, IdCatalogocompra AS Id, Nombre AS descripcion, Estado, Orden, NombreIngles AS name
FROM         dbo.com_catalogo
WHERE     (IdCatalogocompra_tipo = 'EST_APRO_SOL')


--select * from dbo.vwcom_EstadoAprobacion_sol_compra
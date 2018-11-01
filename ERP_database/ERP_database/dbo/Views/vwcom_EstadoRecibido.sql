
CREATE VIEW [dbo].[vwcom_EstadoRecibido]
AS
SELECT     IdCatalogocompra_tipo AS IdTipoCatalogo, CodCatalogo AS Codigo, IdCatalogocompra AS Id, Nombre AS descripcion, Estado, Orden, NombreIngles AS name
FROM         dbo.com_catalogo
WHERE     (IdCatalogocompra_tipo = 'EST_REC')
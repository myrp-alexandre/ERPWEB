CREATE view [dbo].[vwro_titulos]
as
SELECT     IdCatalogo, IdTipoCatalogo, CodCatalogo AS codigo, ca_descripcion AS descripcion, ca_estado AS estado, ca_orden AS orden
FROM         dbo.ro_Catalogo
where ro_Catalogo.IdTipoCatalogo=4
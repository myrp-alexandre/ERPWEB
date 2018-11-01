create view [dbo].[vwRo_PeriocidadPago]
as
SELECT     IdCatalogo AS Id, CodCatalogo AS Codigo, ca_descripcion, ca_estado, ca_orden, IdTipoCatalogo
FROM         dbo.ro_Catalogo
WHERE     (IdTipoCatalogo = 17)
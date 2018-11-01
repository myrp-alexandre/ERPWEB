
create view [dbo].[vwRo_Catalogo_Bancos]
as

SELECT     dbo.ro_Catalogo.CodCatalogo, dbo.ro_Catalogo.ca_descripcion, dbo.ro_CatalogoTipo.IdTipoCatalogo, dbo.ro_CatalogoTipo.tc_Descripcion
FROM         dbo.ro_Catalogo INNER JOIN
                      dbo.ro_CatalogoTipo ON dbo.ro_Catalogo.IdTipoCatalogo = dbo.ro_CatalogoTipo.IdTipoCatalogo
 where dbo.ro_CatalogoTipo.IdTipoCatalogo=11

CREATE VIEW [dbo].[vwcom_Catalogo_IdAuto_numeric]
AS
SELECT        RIGHT('00000' + CAST(ISNULL(MAX(CAST(IdCatalogocompra AS numeric)), 0) + 1 AS VARCHAR(4)), 4) AS IdCatalogocompra, '' AS observacion
FROM            dbo.com_catalogo
WHERE        (ISNUMERIC(IdCatalogocompra) <> 0)
CREATE TABLE [dbo].[fa_CambioProducto] (
    [IdEmpresa]         INT            NOT NULL,
    [IdSucursal]        INT            NOT NULL,
    [IdBodega]          INT            NOT NULL,
    [IdCambio]          INT            NOT NULL,
    [Fecha]             DATETIME       NOT NULL,
    [Observacion]       VARCHAR (5000) NULL,
    [Estado]            BIT            NOT NULL,
    [IdMovi_inven_tipo] INT            NULL,
    [IdNumMovi]         NUMERIC (18)   NULL,
    CONSTRAINT [PK_fa_CambioProducto] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCambio] ASC),
    CONSTRAINT [FK_fa_CambioProducto_in_Ing_Egr_Inven] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdMovi_inven_tipo], [IdNumMovi]) REFERENCES [dbo].[in_Ing_Egr_Inven] ([IdEmpresa], [IdSucursal], [IdMovi_inven_tipo], [IdNumMovi])
);


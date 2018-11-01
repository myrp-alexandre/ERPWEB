CREATE TABLE [dbo].[fa_factura_x_in_movi_inve] (
    [fa_IdEmpresa]          INT           NOT NULL,
    [fa_IdSucursal]         INT           NOT NULL,
    [fa_IdBodega]           INT           NOT NULL,
    [fa_IdCbteVta]          NUMERIC (18)  NOT NULL,
    [inv_IdEmpresa]         INT           NOT NULL,
    [inv_IdSucursal]        INT           NOT NULL,
    [inv_IdBodega]          INT           NOT NULL,
    [inv_IdMovi_inven_tipo] INT           NOT NULL,
    [inv_IdNumMovi]         NUMERIC (18)  NOT NULL,
    [Observacion]           VARCHAR (250) NULL,
    CONSTRAINT [PK_fa_factura_x_in_movi_inve] PRIMARY KEY CLUSTERED ([fa_IdEmpresa] ASC, [fa_IdSucursal] ASC, [fa_IdBodega] ASC, [fa_IdCbteVta] ASC, [inv_IdEmpresa] ASC, [inv_IdSucursal] ASC, [inv_IdBodega] ASC, [inv_IdMovi_inven_tipo] ASC, [inv_IdNumMovi] ASC),
    CONSTRAINT [FK_fa_factura_x_in_movi_inve_fa_factura] FOREIGN KEY ([fa_IdEmpresa], [fa_IdSucursal], [fa_IdBodega], [fa_IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]),
    CONSTRAINT [FK_fa_factura_x_in_movi_inve_in_movi_inve] FOREIGN KEY ([inv_IdEmpresa], [inv_IdSucursal], [inv_IdBodega], [inv_IdMovi_inven_tipo], [inv_IdNumMovi]) REFERENCES [dbo].[in_movi_inve] ([IdEmpresa], [IdSucursal], [IdBodega], [IdMovi_inven_tipo], [IdNumMovi])
);


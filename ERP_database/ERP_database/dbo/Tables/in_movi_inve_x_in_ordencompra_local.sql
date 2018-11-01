CREATE TABLE [dbo].[in_movi_inve_x_in_ordencompra_local] (
    [IdEmpresa]         INT          NOT NULL,
    [IdSucursal]        INT          NOT NULL,
    [IdBodega]          INT          NOT NULL,
    [IdMovi_inven_tipo] INT          NOT NULL,
    [IdNumMovi]         NUMERIC (18) NOT NULL,
    [IdEmpresaOC]       INT          NOT NULL,
    [IdSucursalOC]      INT          NOT NULL,
    [IdOrdenCompra]     NUMERIC (18) NOT NULL,
    [observacion]       VARCHAR (50) NULL,
    CONSTRAINT [PK_in_movi_inve_x_in_ordencompra_local] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdMovi_inven_tipo] ASC, [IdNumMovi] ASC, [IdEmpresaOC] ASC, [IdSucursalOC] ASC, [IdOrdenCompra] ASC),
    CONSTRAINT [FK_in_movi_inve_x_in_ordencompra_local_com_ordencompra_local] FOREIGN KEY ([IdEmpresaOC], [IdSucursalOC], [IdOrdenCompra]) REFERENCES [dbo].[com_ordencompra_local] ([IdEmpresa], [IdSucursal], [IdOrdenCompra]),
    CONSTRAINT [FK_in_movi_inve_x_in_ordencompra_local_in_movi_inve] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdMovi_inven_tipo], [IdNumMovi]) REFERENCES [dbo].[in_movi_inve] ([IdEmpresa], [IdSucursal], [IdBodega], [IdMovi_inven_tipo], [IdNumMovi])
);


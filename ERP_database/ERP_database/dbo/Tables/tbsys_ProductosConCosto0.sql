CREATE TABLE [dbo].[tbsys_ProductosConCosto0] (
    [IdEmpresa]       INT            NOT NULL,
    [IdProducto]      NUMERIC (18)   NOT NULL,
    [NomProducto]     VARCHAR (1000) NULL,
    [NomPresentacion] VARCHAR (1000) NULL,
    [Lote]            VARCHAR (1000) NULL,
    [FechaVcto]       DATE           NULL,
    [Costo]           FLOAT (53)     NOT NULL,
    CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdProducto] ASC)
);


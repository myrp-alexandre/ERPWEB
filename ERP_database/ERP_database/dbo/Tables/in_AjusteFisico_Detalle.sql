CREATE TABLE [dbo].[in_AjusteFisico_Detalle] (
    [IdEmpresa]        INT          NOT NULL,
    [IdAjusteFisico]   NUMERIC (18) NOT NULL,
    [Secuencia]        INT          NOT NULL,
    [IdProducto]       NUMERIC (18) NOT NULL,
    [StockSistema]     FLOAT (53)   NOT NULL,
    [CantidadAjustada] FLOAT (53)   NOT NULL,
    [StockFisico]      FLOAT (53)   NOT NULL,
    [IdCentroCosto]    VARCHAR (20) NULL,
    CONSTRAINT [PK_in_AjusteFisico_Detalle] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAjusteFisico] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_in_AjusteFisico_Detalle_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_in_AjusteFisico_Detalle_in_ajusteFisico] FOREIGN KEY ([IdEmpresa], [IdAjusteFisico]) REFERENCES [dbo].[in_ajusteFisico] ([IdEmpresa], [IdAjusteFisico]),
    CONSTRAINT [FK_in_AjusteFisico_Detalle_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);


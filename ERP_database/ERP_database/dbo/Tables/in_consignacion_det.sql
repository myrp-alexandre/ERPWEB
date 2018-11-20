CREATE TABLE [dbo].[in_consignacion_det] (
    [IdEmpresa]      INT           NOT NULL,
    [IdConsignacion] DECIMAL (18)  NOT NULL,
    [Secuencial]     INT           NOT NULL,
    [IdProducto]     NUMERIC (18)  NULL,
    [IdUnidadMedida] VARCHAR (25)  NOT NULL,
    [Cantidad]       INT           NULL,
    [Precio]         FLOAT (53)    NULL,
    [Observacion]    VARCHAR (MAX) NULL,
    CONSTRAINT [PK_in_consignacion_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdConsignacion] ASC, [Secuencial] ASC),
    CONSTRAINT [FK_in_consignacion_det_In_consignacion] FOREIGN KEY ([IdEmpresa], [IdConsignacion]) REFERENCES [dbo].[In_consignacion] ([IdEmpresa], [IdConsignacion]),
    CONSTRAINT [FK_in_consignacion_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);


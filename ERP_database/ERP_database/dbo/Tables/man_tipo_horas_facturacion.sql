CREATE TABLE [dbo].[man_tipo_horas_facturacion] (
    [IdEmpresa]      INT           NOT NULL,
    [IdTipo]         INT           NOT NULL,
    [IdProducto]     NUMERIC (18)  NOT NULL,
    [ti_codigo]      VARCHAR (20)  NOT NULL,
    [ti_observacion] VARCHAR (500) NULL,
    [estado]         BIT           NOT NULL,
    CONSTRAINT [PK_man_tipo_horas_facturacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipo] ASC),
    CONSTRAINT [FK_man_tipo_horas_facturacion_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);


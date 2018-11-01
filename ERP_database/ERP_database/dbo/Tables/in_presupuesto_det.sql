CREATE TABLE [dbo].[in_presupuesto_det] (
    [IdEmpresa]              INT           NOT NULL,
    [IdSucursal]             INT           NOT NULL,
    [IdPresupuesto]          NUMERIC (18)  NOT NULL,
    [Secuencia]              INT           NOT NULL,
    [dp_iva]                 FLOAT (53)    NOT NULL,
    [IdProducto]             NUMERIC (18)  NOT NULL,
    [dp_Cantidad]            FLOAT (53)    NOT NULL,
    [dp_costo]               FLOAT (53)    NOT NULL,
    [dp_porc_des]            FLOAT (53)    NOT NULL,
    [dp_descuento]           FLOAT (53)    NOT NULL,
    [dp_subtotal]            FLOAT (53)    NOT NULL,
    [dp_total]               FLOAT (53)    NOT NULL,
    [dp_ManejaIva]           CHAR (1)      NOT NULL,
    [dp_Costeado]            CHAR (1)      NOT NULL,
    [dp_costo_promedio_hist] FLOAT (53)    NOT NULL,
    [dp_peso]                FLOAT (53)    NOT NULL,
    [dp_observacion]         VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_in_presupuesto_det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdPresupuesto] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_in_presupuesto_det_in_presupuesto] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdPresupuesto]) REFERENCES [dbo].[in_presupuesto] ([IdEmpresa], [IdSucursal], [IdPresupuesto]),
    CONSTRAINT [FK_in_presupuesto_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);


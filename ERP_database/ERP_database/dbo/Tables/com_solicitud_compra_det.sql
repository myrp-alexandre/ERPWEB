CREATE TABLE [dbo].[com_solicitud_compra_det] (
    [IdEmpresa]                      INT           NOT NULL,
    [IdSucursal]                     INT           NOT NULL,
    [IdSolicitudCompra]              NUMERIC (18)  NOT NULL,
    [Secuencia]                      INT           NOT NULL,
    [IdProducto]                     NUMERIC (18)  NULL,
    [do_Cantidad]                    FLOAT (53)    NOT NULL,
    [NomProducto]                    VARCHAR (500) NULL,
    [IdCentroCosto]                  VARCHAR (20)  NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)  NULL,
    [IdPunto_cargo_grupo]            INT           NULL,
    [IdPunto_cargo]                  INT           NULL,
    [IdUnidadMedida]                 VARCHAR (25)  NULL,
    [do_observacion]                 VARCHAR (500) NULL,
    CONSTRAINT [PK_com_solicitud_compra_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdSolicitudCompra] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_com_solicitud_compra_det_com_solicitud_compra] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdSolicitudCompra]) REFERENCES [dbo].[com_solicitud_compra] ([IdEmpresa], [IdSucursal], [IdSolicitudCompra]),
    CONSTRAINT [FK_com_solicitud_compra_det_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_com_solicitud_compra_det_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_com_solicitud_compra_det_ct_punto_cargo_grupo] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo_grupo]) REFERENCES [dbo].[ct_punto_cargo_grupo] ([IdEmpresa], [IdPunto_cargo_grupo]),
    CONSTRAINT [FK_com_solicitud_compra_det_ct_punto_cargo1] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo]) REFERENCES [dbo].[ct_punto_cargo] ([IdEmpresa], [IdPunto_cargo]),
    CONSTRAINT [FK_com_solicitud_compra_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_com_solicitud_compra_det_in_UnidadMedida] FOREIGN KEY ([IdUnidadMedida]) REFERENCES [dbo].[in_UnidadMedida] ([IdUnidadMedida])
);


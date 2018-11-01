CREATE TABLE [dbo].[in_transferencia_det] (
    [IdEmpresa]                      INT            NOT NULL,
    [IdSucursalOrigen]               INT            NOT NULL,
    [IdBodegaOrigen]                 INT            NOT NULL,
    [IdTransferencia]                NUMERIC (18)   NOT NULL,
    [dt_secuencia]                   INT            NOT NULL,
    [IdProducto]                     NUMERIC (18)   NOT NULL,
    [dt_cantidad]                    FLOAT (53)     NOT NULL,
    [tr_Observacion]                 VARCHAR (1000) NULL,
    [IdCentroCosto]                  VARCHAR (20)   NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)   NULL,
    [IdUnidadMedida]                 VARCHAR (25)   NOT NULL,
    [IdPunto_cargo_grupo]            INT            NULL,
    [IdPunto_cargo]                  INT            NULL,
    CONSTRAINT [PK_in_transferencia_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursalOrigen] ASC, [IdBodegaOrigen] ASC, [IdTransferencia] ASC, [dt_secuencia] ASC),
    CONSTRAINT [FK_in_transferencia_det_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_in_transferencia_det_ct_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo]) REFERENCES [dbo].[ct_punto_cargo] ([IdEmpresa], [IdPunto_cargo]),
    CONSTRAINT [FK_in_transferencia_det_ct_punto_cargo_grupo] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo_grupo]) REFERENCES [dbo].[ct_punto_cargo_grupo] ([IdEmpresa], [IdPunto_cargo_grupo]),
    CONSTRAINT [FK_in_transferencia_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_in_transferencia_det_in_transferencia] FOREIGN KEY ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia]) REFERENCES [dbo].[in_transferencia] ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia]),
    CONSTRAINT [FK_in_transferencia_det_in_UnidadMedida] FOREIGN KEY ([IdUnidadMedida]) REFERENCES [dbo].[in_UnidadMedida] ([IdUnidadMedida])
);


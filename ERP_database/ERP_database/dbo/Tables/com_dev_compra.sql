CREATE TABLE [dbo].[com_dev_compra] (
    [IdEmpresa]       INT            NOT NULL,
    [IdSucursal]      INT            NOT NULL,
    [IdBodega]        INT            NOT NULL,
    [IdDevCompra]     NUMERIC (18)   NOT NULL,
    [IdProveedor]     NUMERIC (18)   NOT NULL,
    [Tipo]            VARCHAR (5)    NOT NULL,
    [dv_fecha]        DATETIME       NOT NULL,
    [dv_flete]        FLOAT (53)     NOT NULL,
    [dv_observacion]  VARCHAR (1000) NOT NULL,
    [Estado]          CHAR (1)       NOT NULL,
    [Fecha_Transac]   DATETIME       NULL,
    [Fecha_UltMod]    DATETIME       NULL,
    [IdUsuarioUltMod] CHAR (20)      NULL,
    [FechaHoraAnul]   DATETIME       NULL,
    [IdUsuarioUltAnu] CHAR (20)      NULL,
    [AfectaCosto]     CHAR (1)       NULL,
    [MotivoAnulacion] VARCHAR (500)  NULL,
    CONSTRAINT [PK_com_dev_compra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdDevCompra] ASC),
    CONSTRAINT [FK_com_dev_compra_cp_proveedor] FOREIGN KEY ([IdEmpresa], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor]),
    CONSTRAINT [FK_com_dev_compra_tb_bodega] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega]) REFERENCES [dbo].[tb_bodega] ([IdEmpresa], [IdSucursal], [IdBodega])
);


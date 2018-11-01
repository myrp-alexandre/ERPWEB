CREATE TABLE [dbo].[com_GenerOCompra] (
    [IdEmpresa]       INT            NOT NULL,
    [IdTransaccion]   NUMERIC (18)   NOT NULL,
    [IdSucursal]      INT            NOT NULL,
    [FechaReg]        DATETIME       NOT NULL,
    [Usuario]         VARCHAR (20)   NOT NULL,
    [g_ocObservacion] VARCHAR (1000) NULL,
    [Estado]          CHAR (1)       NOT NULL,
    [IdUsuarioAnula]  VARCHAR (20)   NULL,
    [FechaAnula]      DATETIME       NULL,
    [MotivoAnulacion] VARCHAR (200)  NULL,
    CONSTRAINT [PK_com_GenerOCompra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTransaccion] ASC),
    CONSTRAINT [FK_com_GenerOCompra_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);


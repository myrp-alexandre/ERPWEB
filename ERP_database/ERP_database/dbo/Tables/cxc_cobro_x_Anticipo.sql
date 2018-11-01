CREATE TABLE [dbo].[cxc_cobro_x_Anticipo] (
    [IdEmpresa]       INT           NOT NULL,
    [IdAnticipo]      NUMERIC (18)  NOT NULL,
    [IdSucursal]      INT           NOT NULL,
    [IdCliente]       NUMERIC (18)  NOT NULL,
    [Observacion]     VARCHAR (250) NULL,
    [Fecha]           DATETIME      NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (50)  NULL,
    [Estado]          CHAR (1)      NULL,
    [MotiAnula]       VARCHAR (50)  NULL,
    [IdCaja]          INT           NULL,
    CONSTRAINT [PK_cxc_cobro_x_Anticipo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAnticipo] ASC),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_caj_Caja] FOREIGN KEY ([IdEmpresa], [IdCaja]) REFERENCES [dbo].[caj_Caja] ([IdEmpresa], [IdCaja]),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_fa_cliente] FOREIGN KEY ([IdEmpresa], [IdCliente]) REFERENCES [dbo].[fa_cliente] ([IdEmpresa], [IdCliente]),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);


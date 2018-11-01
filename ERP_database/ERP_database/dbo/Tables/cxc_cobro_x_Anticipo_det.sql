CREATE TABLE [dbo].[cxc_cobro_x_Anticipo_det] (
    [IdEmpresa]        INT          NOT NULL,
    [IdAnticipo]       NUMERIC (18) NOT NULL,
    [Secuencia]        INT          NOT NULL,
    [IdCobro_tipo]     VARCHAR (20) NOT NULL,
    [IdEmpresa_Cobro]  INT          NULL,
    [IdSucursal_cobro] INT          NULL,
    [IdCobro_cobro]    NUMERIC (18) NULL,
    [Fecha_Transac]    DATETIME     NULL,
    [IdUsuario]        VARCHAR (20) NULL,
    [IdUsuarioUltMod]  VARCHAR (20) NULL,
    [Fecha_UltMod]     DATETIME     NULL,
    [IdUsuarioUltAnu]  VARCHAR (20) NULL,
    [Fecha_UltAnu]     DATETIME     NULL,
    [nom_pc]           VARCHAR (50) NULL,
    [ip]               VARCHAR (50) NULL,
    [Estado]           CHAR (1)     NULL,
    [MotiAnula]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cxc_cobro_x_Anticipo_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAnticipo] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_det_cxc_cobro] FOREIGN KEY ([IdEmpresa_Cobro], [IdSucursal_cobro], [IdCobro_cobro]) REFERENCES [dbo].[cxc_cobro] ([IdEmpresa], [IdSucursal], [IdCobro]),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_det_cxc_cobro_tipo] FOREIGN KEY ([IdCobro_tipo]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo]),
    CONSTRAINT [FK_cxc_cobro_x_Anticipo_det_cxc_cobro_x_Anticipo] FOREIGN KEY ([IdEmpresa], [IdAnticipo]) REFERENCES [dbo].[cxc_cobro_x_Anticipo] ([IdEmpresa], [IdAnticipo])
);


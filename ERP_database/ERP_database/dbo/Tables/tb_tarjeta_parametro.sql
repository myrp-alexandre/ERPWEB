CREATE TABLE [dbo].[tb_tarjeta_parametro] (
    [IdEmpresa]             INT          NOT NULL,
    [IdTarjeta]             INT          NOT NULL,
    [IdCtaCble_Comision]    VARCHAR (20) NULL,
    [Porcetaje_Comision]    FLOAT (53)   NULL,
    [IdCobro_tipo_x_Tarj]   VARCHAR (20) NULL,
    [IdCobro_tipo_x_RetFu]  VARCHAR (20) NULL,
    [IdCobro_tipo_x_RetIva] VARCHAR (20) NULL,
    [IdCtaCble_Tarj]        VARCHAR (20) NULL,
    CONSTRAINT [PK_tb_tarjeta_parametro] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarjeta] ASC),
    CONSTRAINT [FK_tb_tarjeta_parametro_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble_Tarj]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble]),
    CONSTRAINT [FK_tb_tarjeta_parametro_ct_plancta1] FOREIGN KEY ([IdEmpresa], [IdCtaCble_Comision]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble]),
    CONSTRAINT [FK_tb_tarjeta_parametro_cxc_cobro_tipo] FOREIGN KEY ([IdCobro_tipo_x_Tarj]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo]),
    CONSTRAINT [FK_tb_tarjeta_parametro_cxc_cobro_tipo1] FOREIGN KEY ([IdCobro_tipo_x_RetFu]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo]),
    CONSTRAINT [FK_tb_tarjeta_parametro_cxc_cobro_tipo2] FOREIGN KEY ([IdCobro_tipo_x_RetIva]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo]),
    CONSTRAINT [FK_tb_tarjeta_parametro_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa]),
    CONSTRAINT [FK_tb_tarjeta_parametro_tb_tarjeta] FOREIGN KEY ([IdTarjeta]) REFERENCES [dbo].[tb_tarjeta] ([IdTarjeta])
);


CREATE TABLE [dbo].[cxc_cobro_tipo_x_anticipo] (
    [IdEmpresa]    INT          NOT NULL,
    [IdCobro_tipo] VARCHAR (20) NOT NULL,
    [posicion]     INT          NULL,
    CONSTRAINT [PK_cxc_cobro_tipo_x_anticipo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCobro_tipo] ASC),
    CONSTRAINT [FK_cxc_cobro_tipo_x_anticipo_cxc_cobro_tipo] FOREIGN KEY ([IdCobro_tipo]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo])
);


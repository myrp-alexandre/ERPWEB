CREATE TABLE [dbo].[caj_Caja_Movimiento_Tipo_x_CtaCble] (
    [IdEmpresa]  INT          NOT NULL,
    [IdTipoMovi] INT          NOT NULL,
    [IdCtaCble]  VARCHAR (20) NULL,
    CONSTRAINT [PK_caj_Caja_Movimiento_Tipo_x_CtaCble_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipoMovi] ASC),
    CONSTRAINT [FK_caj_Caja_Movimiento_Tipo_x_CtaCble_caj_Caja_Movimiento_Tipo] FOREIGN KEY ([IdEmpresa], [IdTipoMovi]) REFERENCES [dbo].[caj_Caja_Movimiento_Tipo] ([IdEmpresa], [IdTipoMovi]),
    CONSTRAINT [FK_caj_Caja_Movimiento_Tipo_x_CtaCble_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);


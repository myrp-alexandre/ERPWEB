CREATE TABLE [Fj_servindustrias].[fa_registro_unidades_x_equipo_det] (
    [IdEmpresa]       INT          NOT NULL,
    [IdPeriodo]       INT          NOT NULL,
    [IdRegistro]      NUMERIC (18) NOT NULL,
    [IdFecha]         INT          NOT NULL,
    [IdActivoFijo]    INT          NOT NULL,
    [IdUnidad_Medida] VARCHAR (25) NOT NULL,
    [IdTipo_Reg_cat]  VARCHAR (15) NOT NULL,
    [Valor]           FLOAT (53)   NOT NULL,
    [fecha_reg]       DATETIME     NULL,
    [fecha_modi]      DATETIME     NULL,
    CONSTRAINT [PK_fa_registro_unidades_x_equipo_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPeriodo] ASC, [IdRegistro] ASC, [IdFecha] ASC, [IdActivoFijo] ASC),
    CONSTRAINT [FK_fa_registro_unidades_x_equipo_det_fa_registro_unidades_x_equipo] FOREIGN KEY ([IdEmpresa], [IdRegistro]) REFERENCES [Fj_servindustrias].[fa_registro_unidades_x_equipo] ([IdEmpresa], [IdRegistro])
);


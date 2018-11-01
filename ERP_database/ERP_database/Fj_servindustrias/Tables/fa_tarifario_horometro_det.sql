CREATE TABLE [Fj_servindustrias].[fa_tarifario_horometro_det] (
    [IdEmpresa]                      INT        NOT NULL,
    [IdTarifario]                    INT        NOT NULL,
    [Secuencia]                      INT        NOT NULL,
    [IdActivoFijo]                   INT        NOT NULL,
    [valor_unidad]                   FLOAT (53) NOT NULL,
    [unidades_minimas]               FLOAT (53) NOT NULL,
    [total_valor_x_unidades_minimas] FLOAT (53) NOT NULL,
    CONSTRAINT [PK_fa_tarifario_horometro_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_tarifario_horometro_det_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_fa_tarifario_horometro_det_fa_tarifario_horometro] FOREIGN KEY ([IdEmpresa], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_horometro] ([IdEmpresa], [IdTarifario])
);


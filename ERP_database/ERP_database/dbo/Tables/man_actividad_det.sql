CREATE TABLE [dbo].[man_actividad_det] (
    [IdEmpresa]        INT          NOT NULL,
    [IdActividad]      NUMERIC (18) NOT NULL,
    [ac_secuencia]     INT          NOT NULL,
    [IdActividad_hijo] NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_man_actividad_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActividad] ASC, [ac_secuencia] ASC),
    CONSTRAINT [FK_man_actividad_det_man_actividad] FOREIGN KEY ([IdEmpresa], [IdActividad]) REFERENCES [dbo].[man_actividad] ([IdEmpresa], [IdActividad])
);


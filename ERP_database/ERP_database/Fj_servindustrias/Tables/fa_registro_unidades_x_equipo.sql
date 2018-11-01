CREATE TABLE [Fj_servindustrias].[fa_registro_unidades_x_equipo] (
    [IdEmpresa]                      INT           NOT NULL,
    [IdRegistro]                     NUMERIC (18)  NOT NULL,
    [IdPeriodo]                      INT           NOT NULL,
    [IdCentroCosto]                  VARCHAR (20)  NOT NULL,
    [Fecha]                          DATETIME      NOT NULL,
    [Observacion]                    VARCHAR (250) NULL,
    [IdUsuarioUltMod]                VARCHAR (20)  NULL,
    [Fecha_UltMod]                   DATETIME      NULL,
    [IdUsuarioUltAnu]                VARCHAR (20)  NULL,
    [Fecha_UltAnu]                   DATETIME      NULL,
    [MotiAnula]                      VARCHAR (200) NULL,
    [nom_pc]                         VARCHAR (50)  NOT NULL,
    [ip]                             VARCHAR (25)  NOT NULL,
    [Estado]                         CHAR (1)      NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)  NULL,
    [estado_cierre]                  BIT           NOT NULL,
    CONSTRAINT [PK_fa_registro_unidades_x_equipo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRegistro] ASC)
);


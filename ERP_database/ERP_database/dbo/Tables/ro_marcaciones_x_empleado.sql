CREATE TABLE [dbo].[ro_marcaciones_x_empleado] (
    [IdEmpresa]                    INT           NOT NULL,
    [IdRegistro]                   NUMERIC (18)  NOT NULL,
    [IdCalendadrio]                INT           NOT NULL,
    [IdEmpleado]                   NUMERIC (18)  NOT NULL,
    [IdTipoMarcaciones]            VARCHAR (10)  NOT NULL,
    [IdNomina]                     INT           NULL,
    [IdPeriodo]                    INT           NULL,
    [es_Hora]                      TIME (0)      NULL,
    [es_fechaRegistro]             DATETIME      NOT NULL,
    [es_anio]                      INT           NULL,
    [es_mes]                       INT           NULL,
    [es_semana]                    INT           NULL,
    [es_dia]                       INT           NULL,
    [es_sdia]                      CHAR (15)     NULL,
    [es_idDia]                     INT           NULL,
    [es_EsActualizacion]           CHAR (1)      NULL,
    [IdTipoMarcaciones_Biometrico] VARCHAR (20)  NULL,
    [Observacion]                  VARCHAR (200) NULL,
    [IdUsuario]                    VARCHAR (20)  NOT NULL,
    [Estado]                       CHAR (1)      NOT NULL,
    [Fecha_Transac]                DATETIME      NOT NULL,
    [Ip]                           VARCHAR (30)  NULL,
    [IdUsuarioUltModi]             VARCHAR (20)  NULL,
    [Fecha_UltMod]                 DATETIME      NULL,
    [IdUsuarioUltAnu]              VARCHAR (20)  NULL,
    [Fecha_UltAnu]                 DATETIME      NULL,
    [nom_pc]                       VARCHAR (50)  NULL,
    [Motivo_Anu]                   VARCHAR (200) NULL,
    CONSTRAINT [PK_ro_marcaciones_x_empleado_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRegistro] ASC),
    CONSTRAINT [FK_ro_marcaciones_x_empleado_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado]),
    CONSTRAINT [FK_ro_marcaciones_x_empleado_ro_marcaciones_tipo] FOREIGN KEY ([IdTipoMarcaciones]) REFERENCES [dbo].[ro_marcaciones_tipo] ([IdTipoMarcaciones])
);








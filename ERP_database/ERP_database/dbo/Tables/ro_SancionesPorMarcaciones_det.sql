CREATE TABLE [dbo].[ro_SancionesPorMarcaciones_det] (
    [IdEmpresa]         INT           NOT NULL,
    [IdAjuste]          INT           NOT NULL,
    [Secuencia]         INT           NOT NULL,
    [IdCalendario]      INT           NOT NULL,
    [IdEmpleado]        NUMERIC (18)  NOT NULL,
    [IdSucursal]        INT           NOT NULL,
    [IdTipoMarcaciones] VARCHAR (10)  NOT NULL,
    [EsHoraHorario]     TIME (7)      NOT NULL,
    [EsHoraMarcacion]   TIME (7)      NOT NULL,
    [Minutos]           FLOAT (53)    NOT NULL,
    [IdRegistro]        NUMERIC (18)  NOT NULL,
    [Observacion]       VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ro_SancionesPorMarcaciones_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAjuste] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ro_SancionesPorMarcaciones_det_ro_marcaciones_tipo] FOREIGN KEY ([IdTipoMarcaciones]) REFERENCES [dbo].[ro_marcaciones_tipo] ([IdTipoMarcaciones]),
    CONSTRAINT [FK_ro_SancionesPorMarcaciones_det_ro_marcaciones_x_empleado] FOREIGN KEY ([IdEmpresa], [IdRegistro]) REFERENCES [dbo].[ro_marcaciones_x_empleado] ([IdEmpresa], [IdRegistro]),
    CONSTRAINT [FK_ro_SancionesPorMarcaciones_det_ro_SancionesPorMarcaciones] FOREIGN KEY ([IdEmpresa], [IdAjuste]) REFERENCES [dbo].[ro_SancionesPorMarcaciones] ([IdEmpresa], [IdAjuste])
);


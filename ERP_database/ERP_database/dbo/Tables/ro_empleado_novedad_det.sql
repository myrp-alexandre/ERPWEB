CREATE TABLE [dbo].[ro_empleado_novedad_det] (
    [IdEmpresa]         INT           NOT NULL,
    [IdNovedad]         NUMERIC (18)  NOT NULL,
    [IdEmpleado]        NUMERIC (18)  NOT NULL,
    [Secuencia]         INT           NOT NULL,
    [IdNomina_tipo]     INT           NULL,
    [IdNomina_Tipo_Liq] INT           NULL,
    [IdRol]             VARCHAR (10)  NULL,
    [IdRubro]           VARCHAR (50)  NULL,
    [FechaPago]         DATETIME      NOT NULL,
    [Valor]             FLOAT (53)    NOT NULL,
    [EstadoCobro]       VARCHAR (50)  NOT NULL,
    [Observacion]       VARCHAR (200) NULL,
    [Estado]            CHAR (1)      NOT NULL,
    [IdCalendario]      VARCHAR (10)  NULL,
    [Num_Horas]         FLOAT (53)    NULL,
    [IdPeriodo]         INT           NULL,
    CONSTRAINT [PK_ro_empleado_novedad_det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNovedad] ASC, [IdEmpleado] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ro_empleado_novedad_det_ro_empleado_Novedad] FOREIGN KEY ([IdEmpresa], [IdNovedad], [IdEmpleado]) REFERENCES [dbo].[ro_empleado_Novedad] ([IdEmpresa], [IdNovedad], [IdEmpleado]),
    CONSTRAINT [FK_ro_empleado_novedad_det_ro_rubro_tipo] FOREIGN KEY ([IdEmpresa], [IdRubro]) REFERENCES [dbo].[ro_rubro_tipo] ([IdEmpresa], [IdRubro])
);


CREATE TABLE [dbo].[man_tecnico] (
    [IdEmpresa]      INT           NOT NULL,
    [IdTecnico]      NUMERIC (18)  NOT NULL,
    [IdEmpleado]     NUMERIC (18)  NOT NULL,
    [te_codigo]      VARCHAR (20)  NOT NULL,
    [te_observacion] VARCHAR (500) NULL,
    [estado]         BIT           NOT NULL,
    CONSTRAINT [PK_man_tecnico] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTecnico] ASC),
    CONSTRAINT [FK_man_tecnico_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
);


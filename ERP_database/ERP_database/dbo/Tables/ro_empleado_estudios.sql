CREATE TABLE [dbo].[ro_empleado_estudios] (
    [IdEmpresa]     INT           NOT NULL,
    [IdEmpleado]    NUMERIC (18)  NOT NULL,
    [Secuencia]     INT           NOT NULL,
    [IdInstitucion] VARCHAR (10)  NOT NULL,
    [Carrera]       VARCHAR (200) NOT NULL,
    [IdEstudios]    VARCHAR (10)  NOT NULL,
    [Observacion]   VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_ro_Empleado_estudios] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ro_empleado_estudios_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
);


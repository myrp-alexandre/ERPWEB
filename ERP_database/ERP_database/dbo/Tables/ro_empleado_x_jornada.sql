CREATE TABLE [dbo].[ro_empleado_x_jornada] (
    [IdEmpresa]   INT          NOT NULL,
    [IdEmpleado]  NUMERIC (18) NOT NULL,
    [Secuencia]   INT          NOT NULL,
    [IdJornada]   INT          NOT NULL,
    [ValorHora]   FLOAT (53)   NOT NULL,
    [MaxNumHoras] NCHAR (10)   NOT NULL,
    CONSTRAINT [PK_ro_empleado_x_jornada] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [Secuencia] ASC)
);


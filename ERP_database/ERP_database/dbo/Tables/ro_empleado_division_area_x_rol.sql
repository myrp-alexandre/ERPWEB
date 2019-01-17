CREATE TABLE [dbo].[ro_empleado_division_area_x_rol] (
    [IdEmpresa]   INT           NOT NULL,
    [IdRol]       INT           NOT NULL,
    [Secuencia]   INT           NOT NULL,
    [IdEmpleado]  NUMERIC (18)  NOT NULL,
    [IDividion]   INT           NOT NULL,
    [IdArea]      INT           NOT NULL,
    [Porcentaje]  FLOAT (53)    NOT NULL,
    [Observacion] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ro_empleado_division_area_x_rol] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRol] ASC, [Secuencia] ASC)
);


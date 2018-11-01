CREATE TABLE [dbo].[ro_archivos_bancos_generacion_x_empleado] (
    [IdEmpresa]  INT          NOT NULL,
    [IdEmpleado] NUMERIC (18) NOT NULL,
    [IdArchivo]  NUMERIC (18) NOT NULL,
    [Valor]      FLOAT (53)   NOT NULL,
    [pagacheque] BIT          NULL,
    CONSTRAINT [PK_ro_archivos_bancos_generacion_x_empleado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [IdArchivo] ASC)
);


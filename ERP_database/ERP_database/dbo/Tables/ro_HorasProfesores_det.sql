CREATE TABLE [dbo].[ro_HorasProfesores_det] (
    [IdEmpresa]     INT           NOT NULL,
    [IdCarga]       NUMERIC (18)  NOT NULL,
    [Secuencia]     INT           NOT NULL,
    [IdEmpresa_nov] INT           NOT NULL,
    [IdNovedad]     NUMERIC (18)  NOT NULL,
    [Observacion]   VARCHAR (MAX) NULL,
    [IdEmpleado]    NUMERIC (18)  NOT NULL,
    CONSTRAINT [PK_ro_HorasProfesores_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCarga] ASC, [Secuencia] ASC)
);


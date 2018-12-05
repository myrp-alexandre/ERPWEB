CREATE TABLE [dbo].[ro_HorasProfesores] (
    [IdEmpresa]       INT           NOT NULL,
    [IdCarga]         NUMERIC (18)  NOT NULL,
    [IdNomina]        INT           NOT NULL,
    [IdNominaTipo]    INT           NOT NULL,
    [IdSucursal]      INT           NOT NULL,
    [IdRubro]         VARCHAR (50)  NOT NULL,
    [FechaCarga]      DATE          NOT NULL,
    [Observacion]     VARCHAR (MAX) NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [Estado]          BIT           NOT NULL,
    [Fecha_Transac]   DATETIME      NOT NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [MotiAnula]       VARCHAR (200) NULL,
    CONSTRAINT [PK_ro_HorasProfesores] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCarga] ASC)
);


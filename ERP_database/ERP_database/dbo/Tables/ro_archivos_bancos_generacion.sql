CREATE TABLE [dbo].[ro_archivos_bancos_generacion] (
    [IdEmpresa]          INT             NOT NULL,
    [IdArchivo]          NUMERIC (18)    NOT NULL,
    [IdNomina]           INT             NOT NULL,
    [IdNominaTipo]       INT             NOT NULL,
    [IdPeriodo]          INT             NOT NULL,
    [IdCuentaBancaria]   INT             NULL,
    [IdProceso_Bancario] VARCHAR (25)    NULL,
    [Cod_Empresa]        VARCHAR (30)    NULL,
    [Nom_Archivo]        VARCHAR (200)   NULL,
    [archivo]            VARBINARY (MAX) NOT NULL,
    [estado]             VARCHAR (50)    NOT NULL,
    [IdUsuario]          VARCHAR (20)    NULL,
    [Fecha_Transac]      DATETIME        NULL,
    [IdUsuarioUltMod]    VARCHAR (20)    NULL,
    [Fecha_UltMod]       DATETIME        NULL,
    [IdUsuarioUltAnu]    VARCHAR (20)    NULL,
    [Fecha_UltAnu]       DATETIME        NULL,
    [IdRol]              NUMERIC (18)    NOT NULL,
    [MotiAnula]          VARCHAR (200)   NULL,
    CONSTRAINT [PK_ro_archivos_bancos_generacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdArchivo] ASC),
    CONSTRAINT [FK_ro_archivos_bancos_generacion_ro_rol] FOREIGN KEY ([IdEmpresa], [IdRol]) REFERENCES [dbo].[ro_rol] ([IdEmpresa], [IdRol])
);






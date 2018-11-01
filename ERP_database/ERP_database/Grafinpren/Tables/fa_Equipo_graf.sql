CREATE TABLE [Grafinpren].[fa_Equipo_graf] (
    [IdEmpresa]         INT          NOT NULL,
    [IdEquipo]          INT          NOT NULL,
    [nom_Equipo]        VARCHAR (50) NOT NULL,
    [estado]            BIT          NOT NULL,
    [IdUsuario]         VARCHAR (50) NULL,
    [Fecha_Transaccion] DATETIME     NULL,
    [IdUsuarioUltModi]  VARCHAR (50) NULL,
    [Fecha_UltMod]      DATETIME     NULL,
    [IdUsuarioUltAnu]   VARCHAR (50) NULL,
    [Fecha_UltAnu]      DATETIME     NULL,
    [MotivoAnulacion]   VARCHAR (50) NULL,
    [nom_pc]            VARCHAR (50) NULL,
    [ip]                VARCHAR (50) NULL,
    CONSTRAINT [PK_fa_Equipo_graf] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEquipo] ASC)
);


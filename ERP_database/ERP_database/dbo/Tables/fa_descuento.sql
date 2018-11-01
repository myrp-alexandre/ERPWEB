CREATE TABLE [dbo].[fa_descuento] (
    [IdEmpresa]         INT           NOT NULL,
    [IdDescuento]       NUMERIC (18)  NOT NULL,
    [de_nombre]         VARCHAR (200) NOT NULL,
    [de_IdCtaCble]      VARCHAR (20)  NOT NULL,
    [de_porcentaje]     FLOAT (53)    NOT NULL,
    [de_observacion]    VARCHAR (200) NULL,
    [Estado]            BIT           NOT NULL,
    [IdUsuarioCreacion] NVARCHAR (50) NULL,
    [FechaCreacion]     DATETIME      NULL,
    [IdUsuarioUltMod]   VARCHAR (50)  NULL,
    [FechaUltMod]       DATETIME      NULL,
    [IdUsuarioUltAnu]   NVARCHAR (50) NULL,
    [Fecha_UltAnu]      DATETIME      NULL,
    [MotiAnula]         VARCHAR (200) NULL,
    [ip]                NVARCHAR (50) NULL,
    [nom_pc]            NVARCHAR (50) NULL,
    CONSTRAINT [PK_fa_descuento] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDescuento] ASC),
    CONSTRAINT [FK_fa_descuento_ct_plancta] FOREIGN KEY ([IdEmpresa], [de_IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);


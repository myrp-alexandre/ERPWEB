CREATE TABLE [dbo].[fa_TipoNota] (
    [IdTipoNota]      INT           NOT NULL,
    [CodTipoNota]     VARCHAR (20)  NULL,
    [Tipo]            CHAR (1)      NOT NULL,
    [No_Descripcion]  VARCHAR (150) NOT NULL,
    [GeneraMoviInven] BIT           NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (25)  NULL,
    [Estado]          CHAR (1)      NOT NULL,
    [MotiAnula]       VARCHAR (200) NULL,
    CONSTRAINT [PK_fa_TipoNota] PRIMARY KEY CLUSTERED ([IdTipoNota] ASC)
);


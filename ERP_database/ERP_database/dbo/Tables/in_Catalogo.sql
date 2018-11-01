CREATE TABLE [dbo].[in_Catalogo] (
    [IdCatalogo]      VARCHAR (15)  NOT NULL,
    [IdCatalogo_tipo] INT           NOT NULL,
    [Nombre]          VARCHAR (100) NOT NULL,
    [Estado]          CHAR (1)      NOT NULL,
    [Abrebiatura]     VARCHAR (10)  NULL,
    [NombreIngles]    VARCHAR (50)  NULL,
    [Orden]           INT           NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [FechaUltMod]     DATETIME      NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (25)  NULL,
    CONSTRAINT [PK_in_Catalogo] PRIMARY KEY CLUSTERED ([IdCatalogo] ASC),
    CONSTRAINT [FK_in_Catalogo_in_CatalogoTipo] FOREIGN KEY ([IdCatalogo_tipo]) REFERENCES [dbo].[in_CatalogoTipo] ([IdCatalogo_tipo])
);


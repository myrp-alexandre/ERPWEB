CREATE TABLE [dbo].[ct_punto_cargo] (
    [IdEmpresa]           INT           NOT NULL,
    [IdPunto_cargo]       INT           NOT NULL,
    [codPunto_cargo]      VARCHAR (20)  NOT NULL,
    [nom_punto_cargo]     VARCHAR (250) NOT NULL,
    [Estado]              CHAR (1)      NOT NULL,
    [IdPunto_cargo_grupo] INT           NULL,
    CONSTRAINT [PK_ct_punto_cargo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPunto_cargo] ASC),
    CONSTRAINT [FK_ct_punto_cargo_ct_punto_cargo_grupo] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo_grupo]) REFERENCES [dbo].[ct_punto_cargo_grupo] ([IdEmpresa], [IdPunto_cargo_grupo])
);


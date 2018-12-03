CREATE TABLE [dbo].[Af_Activo_fijo_CtaCble] (
    [IdEmpresa]    INT          NOT NULL,
    [IdActivoFijo] INT          NOT NULL,
    [Secuencia]    INT          NOT NULL,
    [IdCatalogo]   VARCHAR (35) NOT NULL,
    [IdCtaCble]    VARCHAR (20) NOT NULL,
    [Porcentaje]   FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_Af_Activo_fijo_CtaCble] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActivoFijo] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_Af_Activo_fijo_CtaCble_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_Af_Activo_fijo_CtaCble_Af_Catalogo] FOREIGN KEY ([IdCatalogo]) REFERENCES [dbo].[Af_Catalogo] ([IdCatalogo]),
    CONSTRAINT [FK_Af_Activo_fijo_CtaCble_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);


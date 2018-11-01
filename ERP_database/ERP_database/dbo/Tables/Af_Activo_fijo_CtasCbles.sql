CREATE TABLE [dbo].[Af_Activo_fijo_CtasCbles] (
    [IdEmpresa]         INT           NOT NULL,
    [IdActivoFijo]      INT           NOT NULL,
    [IdTipoCuenta]      VARCHAR (20)  NOT NULL,
    [Secuencia]         INT           NOT NULL,
    [porc_distribucion] FLOAT (53)    NOT NULL,
    [IdCtaCble]         VARCHAR (20)  NOT NULL,
    [IdCentroCosto]     VARCHAR (20)  NULL,
    [Observacion]       VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_Af_Activo_fijo_Cuentas_contables] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActivoFijo] ASC, [IdTipoCuenta] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_Af_Activo_fijo_CtasCbles_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_Af_Activo_fijo_CtasCbles_Af_Activo_fijo_CtasCbles_Tipo] FOREIGN KEY ([IdTipoCuenta]) REFERENCES [dbo].[Af_Activo_fijo_CtasCbles_Tipo] ([IdTipoCuenta]),
    CONSTRAINT [FK_Af_Activo_fijo_CtasCbles_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_Af_Activo_fijo_CtasCbles_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);


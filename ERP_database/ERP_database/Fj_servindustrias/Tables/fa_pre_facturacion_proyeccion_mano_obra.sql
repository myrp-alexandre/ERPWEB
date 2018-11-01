CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion_proyeccion_mano_obra] (
    [IdEmpresa]               INT          NOT NULL,
    [IdPrefacturacion]        NUMERIC (18) NOT NULL,
    [IdPeriodo]               INT          NOT NULL,
    [IdCargo]                 INT          NOT NULL,
    [IdCentroCosto]           VARCHAR (20) NOT NULL,
    [IdSubcentroCosto]        VARCHAR (20) NOT NULL,
    [valor_proyectado]        FLOAT (53)   NOT NULL,
    [ValorRealManoObra]       FLOAT (53)   NULL,
    [ValorModificadoManoObra] FLOAT (53)   NULL,
    [DiferenciaManoObra]      FLOAT (53)   NULL,
    CONSTRAINT [PK_fa_pre_facturacion_proyeccion_mano_obra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPrefacturacion] ASC, [IdPeriodo] ASC, [IdCargo] ASC, [IdCentroCosto] ASC, [IdSubcentroCosto] ASC),
    CONSTRAINT [FK_fa_pre_facturacion_proyeccion_mano_obra_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdSubcentroCosto]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_pre_facturacion_proyeccion_mano_obra_ro_cargo] FOREIGN KEY ([IdEmpresa], [IdCargo]) REFERENCES [dbo].[ro_cargo] ([IdEmpresa], [IdCargo])
);


CREATE TABLE [Fj_servindustrias].[Af_Activo_fijo_x_ct_punto_cargo] (
    [IdEmpresa_AF]     INT          NOT NULL,
    [IdActivoFijo_AF]  INT          NOT NULL,
    [IdEmpresa_PC]     INT          NOT NULL,
    [IdPunto_cargo_PC] INT          NOT NULL,
    [observacion]      VARCHAR (50) NULL,
    CONSTRAINT [PK_Af_Activo_fijo_x_ct_punto_cargo] PRIMARY KEY CLUSTERED ([IdEmpresa_PC] ASC, [IdPunto_cargo_PC] ASC),
    CONSTRAINT [FK_Af_Activo_fijo_x_ct_punto_cargo_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa_AF], [IdActivoFijo_AF]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_Punto_cargo] FOREIGN KEY ([IdEmpresa_PC], [IdPunto_cargo_PC]) REFERENCES [dbo].[ct_punto_cargo] ([IdEmpresa], [IdPunto_cargo])
);


CREATE TABLE [dbo].[Af_Activo_fijo_x_Af_Activo_fijo] (
    [IdEmpresa]          INT NOT NULL,
    [IdActivoFijo_padre] INT NOT NULL,
    [IdActivoFijo_hijo]  INT NOT NULL,
    CONSTRAINT [PK_Af_Activo_fijo_x_Af_Activo_fijo_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActivoFijo_padre] ASC, [IdActivoFijo_hijo] ASC)
);

